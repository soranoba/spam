%%%-------------------------------------------------------------------
%% @doc spam top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module('spam_simple_sup').

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
    Children = [
                {Mod1, {Mod1, start_link, [a]}, permanent, 5000, worker, [Mod1]}
               ],
    {ok, { {simple_one_for_one, 5, 10}, Children} }.

%%====================================================================
%% Internal functions
%%====================================================================
