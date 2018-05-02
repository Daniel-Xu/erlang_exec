-module(day2).
-export([run/0]).

run() ->
    {ok, Data} = file:read_file("data/day2.txt"),
    Lines = binary:split(Data, [<<"\n">>], [global]),
    calc(Lines, 0).

calc([<<>> | _], Res) -> Res;
calc([H | T], Res) ->
    erlang:display(H),
    {match, [Length, Width, Height]} = re:run(H, "(\\d+)x(\\d+)x(\\d+)", [{capture, all_but_first, binary}]),
    MapedResult = lists:map(fun binary_to_integer/1, [Length, Width, Height]),
    [A, B, C] = lists:sort(MapedResult),
    %% calc(T, Res + A * B * 2 + A * C * 2 + B * C * 2 + A * B).
    %% This is for part two
    calc(T, Res + A * 2  + B * 2 + A * B * C).
