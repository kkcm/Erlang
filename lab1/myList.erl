
%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. mar 2018 13:52
%%%-------------------------------------------------------------------
-module(myList).
-author("kubi").

%% API
-export([contains/2, duplicateElements/1, sumFloats/1]).


contains ([], A) -> false;
contains ([H | T], A) when H == A -> true;
contains ([H | T], A) -> contains(T, A).

duplicateElements ([]) -> [];
duplicateElements ([H | T]) -> [ H | [H | duplicateElements(T)]].

sumFloats([]) -> 0;
sumFloats([H | T]) -> H + sumFloats(T).