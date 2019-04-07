-module(ejercicio2).

-export([start/0, add_matrices/2, spawn_sums/3, add_matrices_receive/4, add_rows/3, get_Matrix/3]).



add_matrices(Mat1, Mat2) ->

    % Create ETS table for partial results
    Table = ets:new(t,[set, public]),
    
    % Register function for receiving process
    register(receive_sum, spawn(ejercicio2, add_matrices_receive, [1, length(Mat1), Table, self()])),

    % Spawn sums for all rows
    spawn_sums(1, Mat1, Mat2),

    receive 
        {finished, Result} ->        
            Result
    end.
    
    
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
add_matrices_receive(Sum_number, Sums_to_complete, Table, Parent_PID) ->

    receive
         {added, SumResult, RowNumber} ->

                % Add result to ets table
                ets:insert(Table, {RowNumber, SumResult}),
                
                % Continue receiving sums if there are any pending
                if
                    Sum_number < Sums_to_complete ->
                        add_matrices_receive(Sum_number+1, Sums_to_complete, Table, Parent_PID);

                 %Return result to parent after all sums have been completed
                    true ->
                        unregister(receive_sum),
                        Parent_PID ! {finished, get_Matrix(Table, 1, Sums_to_complete)}
                end
    end.

% Function for adding up two rows send result back to parent process
add_rows(RowNumber, Row1, Row2) ->
    receive_sum ! {(added), lists:zipwith(fun(X, Y) -> X+Y end, tuple_to_list(Row1), tuple_to_list(Row2)), RowNumber}.

    
% Function returning list of lists (matrix) out of Table
get_Matrix(Table, Current_Row, Total_Rows) ->    

    
    if 
        Current_Row < Total_Rows ->
            lists:nth(1, ets:match(Table,{Current_Row, '$2'})) ++ get_Matrix(Table, Current_Row+1, Total_Rows);
        true ->
            lists:nth(1, ets:match(Table,{Current_Row, '$2'}))
    end.
            


start() ->
            io:format("~p~n", [add_matrices( 
                                            [[1,2,3],
                                            [4,5,6], 
                                            [7,8,9]],

                                            [[10,11,12],
                                            [13,14,15], 
                                            [16,17,18]]
                                            )]),
                        
                        
            add_matrices( 
                        [[1,2],
                        [4,5]],

                        [[11,12],
                        [13,14]]
                        ).
