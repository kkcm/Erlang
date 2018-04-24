%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. kwi 2018 08:43
%%%-------------------------------------------------------------------
-module(onp).
-author("kubi").

%% API
-export([onp/1, checkList/1]).

% konwersja ponadych wyrażeń

% 1 + 2 * 3 - 4 / 5 + 6                         -> 1 2 3 * + 4 5 / - 6 +
% 1 + 2 + 3 + 4 + 5 + 6 * 7                     -> 1 2 3 4 5 6 7 * + + + + +
% ( (4 + 7) / 3 ) * (2 - 19)                    -> 4 7 + 3 / 2 19 - *
% 17 * (31 + 4) / ( (26 - 15) * 2 - 22 ) - 1    -> 17 31 4 + * 26 15 - 2 * 22 - / 1 -

onp(L) -> count(checkList(string:tokens(L, " ")), []).

checkList([]) -> [];
checkList([H | T]) -> [checkOperation(H) | checkList(T)].

checkOperation(X) -> case X of
                        "+" -> "+";
                        "-" -> "-";
                        "*" -> "*";
                        "/" -> "/";
                        "sqrt" -> "sqrt";
                        "pow" -> "pow";
                        "sin" -> "sin";
                        "cos" -> "cos";
                        "tg" -> "tg";
                        "ctg" -> "ctg";
                        _ -> checkNumber(X)
                      end.
checkNumber(X) ->
  {FloatTest, _} = string:list_to_float(X),
  case FloatTest of
    error -> {IntegerTest, _} = string:list_to_integer(X),
      case IntegerTest of
        error -> error("You typed wrong input.");
        _ -> IntegerTest
      end;
    _ -> FloatTest
  end.

count([], [Sol]) -> Sol;
count([], []) -> error("Something wrong, probably not correct RPN expression.");
count([], [_, _ | _]) -> error("Something wrong, probably it isn't correct RPN expression.");
count([H | T], S) -> case H of
                           "+" -> count(T, addOp(doublePop(S)));
                           "-" -> count(T, subOp(doublePop(S)));
                           "*" -> count(T, mulOp(doublePop(S)));
                           "/" -> count(T, divOp(doublePop(S)));
                           "sqrt" -> count(T, sqrtOp(pop(S)));
                           "pow" -> count(T, powOp(doublePop(S)));
                           "sin" -> count(T, sinOp(pop(S)));
                           "cos" -> count(T, cosOp(pop(S)));
                           "tg" -> count(T, tgOp(pop(S)));
                           "ctg" -> count(T, ctgOp(pop(S)));
                           _ -> count(T, push(H, S))
                         end.

addOp({A, B, T}) -> push(B + A, T).
subOp({A, B, T}) -> push(B - A, T).
mulOp({A, B, T}) -> push(B * A, T).
divOp({A, B, T}) -> case A of
                      0 -> error ("You wanted to divide by 0. It isn't allowed.");
                      _ -> push(B / A, T)
                    end.
sqrtOp({A, T}) -> push(math:sqrt(A), T).
powOp({A, B, T}) -> push(math:pow(A, B), T).
sinOp({A, T}) -> push(math:sin(A), T).
cosOp({A, T}) -> push(math:cos(A), T).
tgOp({A, T}) -> push(math:tan(A), T).
ctgOp({A, T}) -> push(1 / math:tan(A), T).

pop([]) -> error("You wanted to pop from empty stack, probably it isn't correct RPN expression.");
pop([A | T]) -> {A, T}.

doublePop([]) -> error("You wanted to doblePop from empty stack, probably it isn't correct RPN expression.");
doublePop([_]) -> error("You wanted to doublePop from one-element stack, probably it isn't correct RPN expression.");
doublePop([A, B | T]) -> {A, B, T}.

push(X, T) -> [X | T].
