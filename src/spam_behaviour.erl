-module(spam_behaviour).

-optional_callbacks([b/0]).

-callback a() -> ok.
-callback b() -> ok.
