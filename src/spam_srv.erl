-module(spam_srv).
-behaviour(gen_server).

-export([start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, code_change/3, terminate/2]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    _ = timer:send_interval(1000, polling),
    {ok, state}.

handle_call(_, _, State) ->
    {noreply, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(polling, State) ->
    _ = case code:priv_dir(spam) of
            {error, bad_name} -> io:format("code:priv_dir(spam) -> {error, bad_name}~n", []);
            PrivDir ->
                Echo = filename:join([PrivDir, "echo.sh"]),
                io:format("~p~n", [PrivDir]),
                io:format("~p~n", [os:cmd("sh -e " ++ Echo)])
        end,
    {noreply, State}.

terminate(_, _) ->
    ok.

code_change(_, State, _) ->
    {ok, State}.
