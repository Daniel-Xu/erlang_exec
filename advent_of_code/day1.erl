-module(day1).
-export([run/1]).

run(Name) ->
    {ok, Data} = file:read_file(Name),
    %% calc(Data, 0).
    calc_pos(Data, 0, 0).

calc(<<>>, Acc) -> Acc;
calc(<<"(", T/binary>>, Acc) ->
    calc(T, Acc + 1);
calc(<<")", T/binary>>, Acc) ->
    calc(T, Acc - 1).

calc_pos(_, -1, Pos) -> Pos;
calc_pos(<<"(", T/binary>>, Acc, Pos) ->
    calc_pos(T, Acc + 1, Pos + 1);
calc_pos(<<")", T/binary>>, Acc, Pos) ->
    calc_pos(T, Acc - 1, Pos + 1).
