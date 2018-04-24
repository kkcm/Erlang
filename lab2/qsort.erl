%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. kwi 2018 13:06
%%%-------------------------------------------------------------------
-module(qsort).
-author("kubi").

%% API
-export([qs/1, lessThan/2, grtEqThan/2, randomElems/3, getTime/1, compareSpeeds/3]).

lessThan(List, Arg) -> [ X || X <- List, X < Arg].

grtEqThan(List, Arg) -> [ X || X <- List, X >= Arg].

qs([]) -> [];
qs([Pivot|Tail]) -> qs( lessThan(Tail,Pivot) ) ++ [Pivot] ++ qs( grtEqThan(Tail,Pivot) ).

randomElems(N,Min,Max) -> [rand:uniform(Max - Min) + Min  || X <- lists:seq(1, N)].

compareSpeeds(List, Fun1, Fun2) ->
  io:format("Twoj czas dla pierwszej funkcji to: ~w~n", [getTime(timer:tc(Fun1, [List]))]),
  io:format("Twoj czas dla drugiej funckji to: ~w ~n", [getTime(timer:tc(Fun2, [List]))]).


getTime({T, _}) -> T.

