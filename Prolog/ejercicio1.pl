/* Return cumulative list of L */
/* PARAMETERS */
/* L - LIST FOR WHICH TO FIND CUMULATIVE */
/* R - RESULT */

cumulativelist(L, R) :-
    [A|B] = L,
    [C|D] = R,

    /* Both lists have the same head */
    C is A,                 
    
    /* Second element is sum of first & second */
    cumulativevalue(C, B, D).

/* Get cumulative value of two elements */
/* PARAMETERS */
/* A - HEAD OF FIRST LIST */
/* B - TAIL OF FIRST LIST */
/* D - TAIL OF RESULTING LIST */
cumulativevalue(A, B, D) :-
    [B2|B3] = B,              
    [D2|D3] = D,
    D2 is A + B2,
    /* Recursive call */
    cumulativevalue(D2, B3, D3).

cumulativevalue(A,[],[]).
