%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. mar 2018 13:36
%%%-------------------------------------------------------------------
-module(plik).
-author("kubi").

%% API
-export([power/2]).

power (A, 0) -> 1;
power (A, B) -> A * power (A, B-1).