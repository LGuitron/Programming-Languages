/*

LIST MAXIMUM

*/
/* Get max value from a List */
maxlist(List,Max) :-
    [Val|Tail] = List,
    maxval(Val,Tail,Max).

/* Max between a value and a list */
maxval(Val, List, Max) :-
    [Head|Tail] = List,
    maxnums(Val, Head, Temp),        /* Max between current max and next value in Temp */
    maxval(Temp, Tail, Max).

/* When tail is empty return Max */
maxval(Val, [],Max) :-
    Max is Val.
    
/* Max value between two numbers */
maxnums(Val1, Val2, Max) :-
    Val1 >= Val2,
    Max is Val1.
    
/* Max value between two numbers */
maxnums(Val1, Val2, Max) :-
    Val1 < Val2,
    Max is Val2.

/*

LIST MINIMUM

*/ 
    
/* Get max value from a List */
minlist(List,Min) :-
    [Val|Tail] = List,
    minval(Val,Tail,Min).

/* Max between a value and a list */
minval(Val, List, Min) :-
    [Head|Tail] = List,
    minnums(Val, Head, Temp),        /* Max between current max and next value in Temp */
    minval(Temp, Tail, Min).

/* When tail is empty return Max */
minval(Val, [],Min) :-
    Min is Val.
    
/* Min value between two numbers */
minnums(Val1, Val2, Min) :-
    Val1 >= Val2,
    Min is Val2.
    
/* Max value between two numbers */
minnums(Val1, Val2, Min) :-
    Val1 < Val2,
    Min is Val1.
    
    
/*

BUCKET SORT

*/
bucketsort(List, Buckets, Result) :-
    maxlist(List, Maxval),
    minlist(List, Minval),
    Difference is Maxval - Minval,
    Bucketsize is floor(Difference / Buckets),
    getbuckets(List, Minval, Bucketsize, Buckets, [] , Newbuckets),
    cleanlist(Newbuckets, [], Result).
    
/* Function for getting a new list to do bucketsort with */
cleanlist(Bucketlists, Currentlist, Result):-
    [Head|Tail] = Bucketlists,
    addsortedvalue(Head, Currentlist, Newlist),
    cleanlist(Tail,Newlist,Result).
    
/* All buckets have been checked */
cleanlist([], Currentlist, Result):-
    append(Currentlist, [], Result).
    
/* Function to append values to list (sorted) */
/* Append already sorted numbers */
addsortedvalue([], List, Result):-
    append(List, [], Result).

addsortedvalue(Value, List, Result):-
    length(Value, X),
    X > 0,
    append(List, [Value], Result).

/* Get buckets as list of lists */
getbuckets(List, Minval, Bucketsize, Bucketsremaining ,Currentbuckets, Result) :-
    Bucketsremaining > 0,
    createbucket(Minval, Minval + Bucketsize, List, Newbucket),
    append(Currentbuckets,[Newbucket], Newbucketlist),
    Newminval is Minval + Bucketsize + 1,
    Newbucketsr is Bucketsremaining - 1,
    getbuckets(List, Newminval, Bucketsize, Newbucketsr, Newbucketlist, Result).
    
/* No more buckets remaining */
getbuckets(List, Minval, Bucketsize, 0, Currentbuckets, Result):-
    append(Currentbuckets, [], Result).
    

/* Create a bucket with given boundaries */
createbucket(Lower, Upper, Remaininglist, Resultbucket) :-
    buildbucket(Lower, Upper, Remaininglist,[], Resultbucket).

/* Add element to bucket succesfully */
buildbucket(Lower, Upper, Remaininglist, Currentbucket, Result) :-
    [Value|Tail] = Remaininglist,
    Value >= Lower,
    Value =< Upper,
    append(Currentbucket, [Value], Newbucket),
    buildbucket(Lower, Upper, Tail, Newbucket, Result).
    
/* Fail to add because of being smaller than lower */
buildbucket(Lower, Upper, Remaininglist, Currentbucket,Result) :-
    [Value|Tail] = Remaininglist,
    Value < Lower,
    buildbucket(Lower, Upper, Tail, Currentbucket, Result).

/* Fail to add because of being greaten than upper */
buildbucket(Lower, Upper, Remaininglist, Currentbucket,Result) :-
    [Value|Tail] = Remaininglist,
    Value > Upper,
    buildbucket(Lower, Upper, Tail, Currentbucket, Result).
    
/* Bucket Complete */
buildbucket(Lower, Upper, [], Currentbucket, Result) :-
    append(Currentbucket, [], Result).
