%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. kwi 2018 13:20
%%%-------------------------------------------------------------------
-module(higherOrderFun).
-author("kubi").

%% API
-export([map_function/2, filter_function/2]).

map_function (F , []) -> [];
map_function (F , [H|T]) -> [F(H) | map_function(F, T)].

filter_function (Pred, L) -> lists:reverse(filter_function (Pred, L, [])).

filter_function(_, [], Acc) -> Acc;
filter_function (Pred, [H|T], Acc) ->
  case Pred(H) of
    true -> filter_function(Pred, T, [H|Acc]);
    false -> filter_function(Pred, T, Acc)
  end.