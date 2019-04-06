-module(ejercicio2).

-export([start/0, add_matrices/2, add_matrices_spawn/2 , add_matrices_receive/0, add_rows/4]).






add_matrices(Mat1, Mat2) ->

    %spawn(ejercicio2, add_rows, [list_to_tuple(lists:nth(1, Mat1)), list_to_tuple(lists:nth(1, Mat2))]).
    %io:format("~p~n",spawn(ejercicio2, add_rows, [list_to_tuple(lists:nth(1, Mat1)), list_to_tuple(lists:nth(1, Mat2))])).
    
    
    
    % Sequential function call
    %add_rows(list_to_tuple(lists:nth(1, Mat1)), list_to_tuple(lists:nth(1, Mat2))).

    % Threads for adding rows
    spawn(ejercicio2, add_rows, [1, list_to_tuple(lists:nth(1, Mat1)), list_to_tuple(lists:nth(1, Mat2)), self()]),
    spawn(ejercicio2, add_rows, [2, list_to_tuple(lists:nth(2, Mat1)), list_to_tuple(lists:nth(2, Mat2)), self()]),
    spawn(ejercicio2, add_rows, [3, list_to_tuple(lists:nth(3, Mat1)), list_to_tuple(lists:nth(3, Mat2)), self()]),
    
    receive
         {added1, SumResult} ->
            io:format("~p~n", [SumResult]);
         
         {added2, SumResult} ->
            io:format("~p~n", [SumResult]);
        
         {added3, SumResult} ->
            io:format("~p~n", [SumResult])
    end,
    
    receive
         {added1, SumResult2} ->
            io:format("~p~n", [SumResult2]);
         
         {added2, SumResult2} ->
            io:format("~p~n", [SumResult2]);
        
         {added3, SumResult2} ->
            io:format("~p~n", [SumResult2])
    end,
    
    receive
         {added1, SumResult3} ->
            io:format("~p~n", [SumResult3]);
         
         {added2, SumResult3} ->
            io:format("~p~n", [SumResult3]);
        
         {added3, SumResult3} ->
            io:format("~p~n", [SumResult3])
    end.
    
    

% Function to spawn threads for calculating the sum of each row in the matrix
add_matrices_spawn(Mat1, Mat2) ->

    % Threads for adding rows
    spawn(ejercicio2, add_rows, [1, list_to_tuple(lists:nth(1, Mat1)), list_to_tuple(lists:nth(1, Mat2)), self()]),
    spawn(ejercicio2, add_rows, [2, list_to_tuple(lists:nth(2, Mat1)), list_to_tuple(lists:nth(2, Mat2)), self()]),
    spawn(ejercicio2, add_rows, [3, list_to_tuple(lists:nth(3, Mat1)), list_to_tuple(lists:nth(3, Mat2)), self()]).

    
% Function to receive
add_matrices_receive() ->

    receive
         {added1, SumResult} ->
            io:format("~p~n", [SumResult]);
         
         {added2, SumResult} ->
            io:format("~p~n", [SumResult]);
        
         {added3, SumResult} ->
            io:format("~p~n", [SumResult])
    end,
    
    receive
         {added1, SumResult2} ->
            io:format("~p~n", [SumResult2]);
         
         {added2, SumResult2} ->
            io:format("~p~n", [SumResult2]);
        
         {added3, SumResult2} ->
            io:format("~p~n", [SumResult2])
    end,
    
    receive
         {added1, SumResult3} ->
            io:format("~p~n", [SumResult3]);
         
         {added2, SumResult3} ->
            io:format("~p~n", [SumResult3]);
        
         {added3, SumResult3} ->
            io:format("~p~n", [SumResult3])
    end.

    
    
% Function for adding up two rows
% add_rows(Row1, Row2) ->
%    lists:zipwith(fun(X, Y) -> X+Y end, tuple_to_list(Row1), tuple_to_list(Row2)).
    

% Function for adding up two rows send result back to parent process
add_rows(RowNumber, Row1, Row2, Parent_PID) ->
    
    case RowNumber of 
        1 -> Parent_PID ! {(added1), lists:zipwith(fun(X, Y) -> X+Y end, tuple_to_list(Row1), tuple_to_list(Row2))};
        2 -> Parent_PID ! {(added2), lists:zipwith(fun(X, Y) -> X+Y end, tuple_to_list(Row1), tuple_to_list(Row2))};
        3 -> Parent_PID ! {(added3), lists:zipwith(fun(X, Y) -> X+Y end, tuple_to_list(Row1), tuple_to_list(Row2))}
    end.

    
    
start() ->
    %lists:zipwith(fun(X, Y) -> X+Y end, [1,2,3], [11,12,13]).
    %spawn(ejercicio2, add_rows, [{1,2,3}, {3,2,1}]),
    
    % add_rows({1,2,3}, {3,2,10}).
    
    %spawn(ejercicio2, add_matrices, [
    %                                 [[1,2,3],
    %                                  [4,5,6], 
    %                                  [7,8,9]],

    %                                 [[1,2,4],
    %                                  [4,5,6], 
    %                                  [7,8,9]]
    %                                          ]),
    
    add_matrices( 
                    [[1,2,3],
                     [1,2,3], 
                     [7,8,9]],

                    [[1,2,4],
                     [8,3,5], 
                     [7,8,9]]
                     ).
    
