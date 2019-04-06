-module(ejercicio1).

-export([start/0, write_pid/3]).

write_pid(Wait_Time, Call_id, 0) ->
    done;

write_pid(Wait_Time, Call_id, Calls_rem) ->
    timer:sleep(Wait_Time),
    io:fwrite("Proceso " ++ integer_to_list(Call_id) ++ " faltan " ++ integer_to_list(Calls_rem-1) ++"\n"),
    write_pid(rand:uniform(10) * 10, Call_id, Calls_rem-1).

start() ->
    spawn(ejercicio1, write_pid, [rand:uniform(10) * 10, 0, 10]),
    spawn(ejercicio1, write_pid, [rand:uniform(10) * 10, 1, 10]),
    spawn(ejercicio1, write_pid, [rand:uniform(10) * 10, 2, 10]),
    spawn(ejercicio1, write_pid, [rand:uniform(10) * 10, 3, 10]).
