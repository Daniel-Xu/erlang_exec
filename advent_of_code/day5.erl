-module(day5).
-export([run/0]).

-define(Vowels, [$a, $e, $i, $o, $u]).
-define(Naughty, [<<"ab">>, <<"cd">>, <<"pq">>, <<"xy">>]).

run() ->
    {ok, Data} = file:read_file("data/day5.txt"),
    Lines = binary:split(Data, [<<"\n">>], [global, trim]),
    Lines1 = lists:filter(
               fun(Elem) ->
                       has_vowel(Elem, 0) and has_no_naughty_char(Elem) and has_repeatition(Elem)
               end, Lines),
    erlang:display({length(Lines), length(Lines1)}).

has_vowel(_, N) when N >= 3 -> true;
has_vowel(<<>>, _N) -> false;
has_vowel(<<H, T/binary>>, N) ->
    N1 = case lists:member(H, ?Vowels) of
             true -> N + 1;
             false -> N
         end,
    has_vowel(T, N1).

%% no naughty characters
has_no_naughty_char(Elem) ->
    case binary:match(Elem, ?Naughty, []) of
        nomatch -> true;
        _ -> false
    end.

% abdee
% use regex
has_repeatition(Elem) ->
    case re:run(Elem, "(.)\\1", []) of
        nomatch -> false;
        _ -> true
    end.
