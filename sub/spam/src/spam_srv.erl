-module(spam_srv).
-behaviour(gen_server).

-export([start_link/0, start_link/1, start_link/2, init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

start_link(X) ->
    gen_server:start_link(?MODULE, [X], []).

start_link(X, Y) ->
    gen_server:start_link(?MODULE, [X, Y], []).

init(_) ->
    _ = timer:send_interval(1000, polling),
    {ok, 1}.

handle_call(_, _, State) ->
    {reply, ok, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(polling, State) ->
    _ = case code:priv_dir(spam) of
            {error, bad_name} -> io:format("code:priv_dir(spam) -> {error, bad_name}~n", []);
            PrivDir ->
                Echo = filename:join([PrivDir, "echo.sh"]),
                %io:format("~p~n", [PrivDir]),
                os:cmd("sh -e " ++ Echo)
        end,
    {noreply, State + 1};
handle_info(_, State) ->
    {noreply, State}.

terminate(_, _) ->
    ok.

code_change(_, State, _) ->
    {ok, State}.
