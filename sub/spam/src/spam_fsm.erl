-module(spam_fsm).
-behaviour(gen_fsm).

-export([start_link/0, init/1, loop/2, loop/3, handle_event/3, handle_sync_event/4, handle_info/3, code_change/4, terminate/3]).

start_link() ->
    gen_fsm:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    {ok, loop, 1, 1000}.

loop(Event, _From, StateData) ->
    loop(Event, StateData).

loop(_Event, StateData) ->
    {next_state, loop, StateData + 1, 1000}.

handle_event(_Event, StateName, StateData) ->
    {next_state, StateName, StateData, 1000}.

handle_sync_event(_Event, _From, StateName, StateData) ->
    {next_state, StateName, StateData, 1000}.

handle_info(Info, StateName, StateData) ->
    io:format("[info] ~p~n", [Info]),
    {next_state, StateName, StateData, 1000}.

terminate(_, _, _) ->
    ok.

code_change(_, State, StateData, _) ->
    {ok, State, StateData}.
