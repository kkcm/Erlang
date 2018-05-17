%%%-------------------------------------------------------------------
%%% @author kubi
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 24. kwi 2018 13:11
%%%-------------------------------------------------------------------
-module(pingpong).
-author("kubi").

%% API
-export([start/0, stop/0, play/1]).

start() ->
  register(ping, spawn(fun() -> loop(ping) end)),
  register(pong, spawn(fun() -> loop(pong) end)).

stop() ->
  pong ! stop,
  ping ! stop.

play(N) ->
%  ping ! "Test other msg.",
  pong ! N.


loop(Player) ->

  receive
    stop -> io:format("~s ~p : STOP!~n", [Player, self()]),
      ok;

    N when is_integer(N) ->   Sender =
      case Player of
        pong -> ping;
        ping -> pong
      end,
%      io:format("Sender: ~s~n", [Sender]),
%      io:format("Player: ~s~n", [Player]),
      timer:sleep(200),

      case N > 0 of
        true -> io:format("~s ~p : Received ~w. Throw to ~s.~n", [Player, self(), N, Sender]),
          Sender ! N - 1,
          loop(Player);
        false -> io:format("~s ~p : Received 0. Game over!~n Waiting for new game.~n", [Player, self()]),
          loop(Player)
      end;
    Msg -> io:format("~s ~p : Received other message: ~s.~n", [Player, self(), Msg]),
      loop(Player)
  after
    20000 -> io:format("~s ~p :Exit after 20sec.~n", [Player, self()])
  end.


