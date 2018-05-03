-module(day4).
-export([run/0]).

-define(Input, "ckczppom").

run() ->
    Res = calc_hash(0),
    erlang:display(Res).

calc_hash(Start) ->
    Start1 = ?Input ++ integer_to_list(Start),
    Res = md5(Start1),
    MatchRes = re:run(Res, "^000000(.*)", [{capture, all_but_first, binary}]),
    case MatchRes of
        nomatch -> calc_hash(Start + 1);
        {match, [MatchRes1]} -> {Start1, MatchRes1}
    end.

md5(S) ->
    string:to_upper(
      lists:flatten([io_lib:format("~2.16.0b",[N]) || <<N>> <= crypto:hash(md5, S)])
     ).
