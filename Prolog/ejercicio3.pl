/* Simpsons Family Tree*/
father(homer, abraham).
father(herbert, abraham).


father(bart, homer).
father(lisa, homer).
father(maggie, homer).
 
father(marge, clancy).
father(patty, clancy).
father(selma, clancy).

mother(homer, moana).
mother(herbert, moana).

mother(bart, marge).
mother(lisa, marge).
mother(maggie, marge).

mother(marge, jackie).
mother(patty, jackie).
mother(selma, jackie).

mother(ling, selma).

/* Parent */
parent(Person, Relative):-
    father(Person, Relative).

parent(Person, Relative):-
    mother(Person, Relative).


/* Sibling */
sibling(Person, Relative) :-
    father(Person, F1),
    father(Relative, F2),
    F1 = F2,
    mother(Person, M1),
    mother(Relative, M2),
    M1 = M2,
    \+ (Relative = Person).


/* Grandparent */
grandparent(Person, Relative) :-
    parent(Person, Parent),
    parent(Parent, Relative).
    
/* Grandchild */
grandchild(Person, Relative):-
    parent(Child, Person),
    parent(Relative, Child).
    
/* Uncle */
uncle(Person, Relative):-
    parent(Person, Parent),
    sibling(Parent, Relative).

/* Nephew */
nephew(Person, Relative):-
    sibling(Person, Sibling),
    parent(Relative, Sibling).

/* Cousin */
cousin(Person, Relative):-
    uncle(Person, Uncle),
    parent(Relative, Uncle).

/* Spouse */
spouse(Person, Relative):-
    parent(Child1, Person),
    parent(Child2, Relative),
    Child1 = Child2,
    \+ (Relative = Person).

/* Sibling in Law */
siblinginlaw(Person, Relative):-
    spouse(Person, Spouse),
    sibling(Spouse, Relative).

/* Parent in Law */
parentinlaw(Person, Relative):-
    spouse(Person, Spouse),
    parent(Spouse, Relative).
