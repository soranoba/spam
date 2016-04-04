%%%-------------------------------------------------------------------
%% @doc spam top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module('spam_sup').

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    Mod1 = spam_srv,
    Mod2 = spam_fsm,
    Mod3 = spam_simple_sup,
    Children = [
                {Mod1, {Mod1, start_link, []}, permanent, 5000, worker, [Mod1]},
                {Mod2, {Mod2, start_link, []}, permanent, 5000, worker, [Mod2]},
                {Mod3, {Mod3, start_link, []}, permanent, 5000, supervisor, [Mod3]}
               ],
    {ok, { {one_for_all, 0, 1}, Children} }.

%%====================================================================
%% Internal functions
%%====================================================================
