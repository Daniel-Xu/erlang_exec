-module(day3).
-export([run/0]).

% use sets in Erlang
run() ->
    {ok, Data} = file:read_file("data/day3.txt"),
    traverse(Data, {0, 0}, sets:from_list([{0, 0}])).

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
