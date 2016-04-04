-module(spam_tests).

-include_lib("eunit/include/eunit.hrl").

a_test_() ->
    [
     fun() ->
             ?debugVal(node())
     end,
     fun() ->
             ?debugVal(application:get_env(bbmustache, a))
     end,
     ?_assertEqual(ok, spam:a())
    ].
