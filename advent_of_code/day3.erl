-module(day3).
-export([run/0]).

% use sets in Erlang
run() ->
    {ok, Data} = file:read_file("data/day3.txt"),
    %% traverse(Data, {0, 0}, sets:from_list([{0, 0}])). This is for part one
    traverse_with_robo(Data, {{0, 0}, {0, 0}}, true, sets:from_list([{0, 0}])).

traverse(<<>>, _, Visited) -> sets:size(Visited);
traverse(<<H, T/binary>>, {X, Y}, Visited) ->
    Location =
        case H of
            $^ -> {X + 1, Y};
            $> -> {X, Y + 1};
            $< -> {X, Y - 1};
            $v -> {X - 1, Y};
            10 -> {X, Y} % handle \n
        end,
    traverse(T, Location, sets:add_element(Location, Visited)).

traverse_with_robo(<<>>, _, _, Visited) -> sets:size(Visited);
traverse_with_robo(<<H, T/binary>>, {{XS, YS},  {XR, YR}}, Turn, Visited) ->
    {LS, LR} =
        case {H, Turn} of
            {$^, true} -> {{XS + 1, YS}, {XR, YR}};
            {$^, false} -> {{XS, YS}, {XR + 1, YR}};
            {$>, true} -> {{XS, YS + 1}, {XR, YR}};
            {$>, false} -> {{XS, YS}, {XR, YR + 1}};
            {$<, true} -> {{XS, YS - 1}, {XR, YR}};
            {$<, false} -> {{XS, YS}, {XR, YR - 1}};
            {$v, true} -> {{XS - 1, YS}, {XR, YR}};
            {$v, false} -> {{XS, YS}, {XR - 1, YR}};
            {10, _} -> {{XS, YS}, {XR, YR}} % handle \n
        end,
    NewVisited = sets:add_element(LS, Visited),
    traverse_with_robo(T, {LS, LR}, (not Turn), sets:add_element(LR, NewVisited)).
