-module(spam).
%-behaviour(spam_behaviour).

-export([a/0]).

a() ->
    bbmustache:render(<<>>, []),
    ok.
