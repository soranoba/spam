#!/usr/bin/env escript
main(_) ->
    InstalledPath = "tmp/spam",
    NowPath       = "_build/default/rel/spam",
    ToStartErlPath = filename:join(NowPath, "releases/start_erl.data"),
    ToVsn = case file:read_file(ToStartErlPath) of
                {ok, D} ->
                    case binary:split(D, [<<" ">>, <<"\n">>], [global, trim]) of
                        [_, ToVsn0] -> ToVsn0;
                        _           -> throw({unsupported_start_erl, ToStartErlPath})
                    end;
                {error, _} ->
                    erlang:halt(1)
            end,
    FromNames = [filename:rootname(X) || X <- filelib:wildcard(filename:join(InstalledPath, "releases/*/*.rel"))],
    ToName    = to_list(filename:join([NowPath, "releases", ToVsn, "spam"])),
    systools:make_relup(ToName, FromNames, FromNames,
                        [{path, [to_list(filename:join(InstalledPath, "lib/*/ebin")),
                                 to_list(filename:join(NowPath, "lib/*/ebin"))]},
                         {outdir, filename:dirname(ToName)}]).

to_list(Str) when is_list(Str) ->
    Str;
to_list(Bin) when is_binary(Bin) ->
    binary_to_list(Bin).
