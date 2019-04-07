-module(ejercicio2).

-export([start/0, add_matrices/2, spawn_sums/3, add_matrices_receive/3, add_rows/3]).



add_matrices(Mat1, Mat2) ->

    % Register function for receiving process
    register(receive_sum, spawn(ejercicio2, add_matrices_receive, [1, length(Mat1), [[], [], []]])),
    
    % Spawn sums for all rows
    spawn_sums(1, Mat1, Mat2).

% Function for spawing sums required recursively
spawn_sums(Current_Row, Mat1, Mat2) ->
    spawn(ejercicio2, add_rows, [Current_Row, list_to_tuple(lists:nth(Current_Row, Mat1)), list_to_tuple(lists:nth(Current_Row, Mat2))]),

    if 
        Current_Row < length(Mat1) ->
            spawn_sums(Current_Row+1, Mat1, Mat2);
        true->
            ok
    end.

    
% Function to receive sum results from threads
add_matrices_receive(Sum_number, Sums_to_complete, Partial_result) ->

    receive
         {added, SumResult, RowNumber} ->
            %ok
            %io:format("~p~n", [SumResult]),
            
            % Continue receiving sums if there are any pending
            if
                Sum_number < Sums_to_complete ->
                    io:format("~p~n", [Partial_result]),
                    
                    % Save partial result and keep receiving the other sums
                    add_matrices_receive(Sum_number+1, Sums_to_complete, lists:sublist(Partial_result,RowNumber-1) ++ [SumResult] ++ lists:nthtail(RowNumber,Partial_result));

            % TODO Once all of the sums have been completed do a matrix multiplication of the result with itself and unregister the process
                true ->
                    %unregister(receive_sum)
                    ok
            end
    end.
    


% Function for adding up two rows send result back to parent process
add_rows(RowNumber, Row1, Row2) ->
    receive_sum ! {(added), lists:zipwith(fun(X, Y) -> X+Y end, tuple_to_list(Row1), tuple_to_list(Row2)), RowNumber}.

start() ->

    add_matrices( 
                    [[1,2,3],
                     [4,5,6], 
                     [7,8,9]],

                    [[10,11,12],
                     [13,14,15], 
                     [16,17,18]]
                     ).
