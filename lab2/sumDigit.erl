%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. kwi 2018 15:32
%%%-------------------------------------------------------------------
-module(sumDigit).
-author("kubi").

%% API
-export([sumDigit/1, sumDigit2/1, filter3/1, filterFromDigitSum3/1]).

sum(X, Acc) -> X + Acc.

numberToDigitList(Number) -> [X-$0 || X <- integer_to_list(Number)].

sumDigit(Number) -> lists:foldl(fun sum/2, 0, numberToDigitList(Number)).

sumDigit2(N) ->
  sumDigit2(N,10).

sumDigit2(N, B) ->
  sumDigit2(N, B, 0).

sumDigit2(0, _, Acc) -> Acc;
sumDigit2(N, B, Acc) when N < B -> Acc + N;
sumDigit2(N, B, Acc) -> sumDigit2(N div B, B, Acc + (N rem B)).

isDivideBy3(Number) -> case Number rem 3 of
                         0 -> true;
                         _ -> false
                       end .

isDigitSumIsDivideBy3(Number) -> isDivideBy3(sumDigit(Number)).

filter3(List) -> lists:filter(fun isDivideBy3/1, List).

filterFromDigitSum3(List) -> lists:filter(fun isDigitSumIsDivideBy3/1, List).

