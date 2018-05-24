sumsq_neg([],0).
sumsq_neg([X|L],Sum):-
    X < 0,
    sumsq_neg(L,Sum1),
    Sum is X * X + Sum1.

sumsq_neg([_|Tail],Sum):-
    sumsq_neg(Tail,Sum).



who_like_all(_,[]).

who_like_all(X,[Y|Tail]):-
	likes(X,Y),
	who_like_all(X,Tail).
	
who_like_all(_,[_|_]):-
	fail.

all_like_all([],[_|_]).
all_like_all([],[]).

all_like_all([X|Tail],What_List):-
	who_like_all(X,What_List),
	all_like_all(Tail,What_List).

all_like_all([_|_],_):-
	fail.



sqrt_table_c(N,M,C):-
	N >= M,
	C is sqrt(N).

sqrt_table(M,M,Result):-
	X is sqrt(M),
	Result = [[M,X]].

sqrt_table(N,M,Result):-
	N >= M,
	sqrt_table_c(N,M,R),
	P is N - 1,
	sqrt_table(P,M,Q),
	Result = [[N, R]|Q].



select_e([X|_],Q):-
	Q = X.

select_ele([Z|[]],X,L1):-
	X = Z,
	L1 = [].

select_ele([Z|List],X,L1):-
	select_e(List,Y),
	not(Y is Z + 1),
	X = Z,
	L1 = List.

select_ele([Z|List],X,L1):-
	select_e(List,Y),
	Y is Z + 1,
	select_ele(List,X,L),
	L1 = L.

chop_up([],NewList):-
	NewList = [].

chop_up([X|[]],NewList):-
	NewList = [X].

chop_up([X|List],NewList):-
	select_e(List,Q),
	not(Q is X + 1),
	chop_up(List,L),
	NewList = [X|L].

chop_up([X|List],NewList):-
	select_e(List,Q),
	Q is X + 1,
	select_ele(List,Y,L1),
	chop_up(L1,L),
	NewList = [[X,Y]|L].




tree(empty,_,empty).

tree(_,_,_).

tree_eval(Value,tree(empty,Num,empty),Eval):-
	Num = z,
	Eval is Value.

tree_eval(_,tree(empty,Num,empty),Eval):-
	number(Num),
	Eval is Num.

tree_eval(Value,tree(L,Op,R),Eval):-
	tree_eval(Value,L,LeftEval),
	tree_eval(Value,R,RightEval),
	Op = '+',
	Eval is LeftEval + RightEval.

tree_eval(Value,tree(L,Op,R),Eval):-
	tree_eval(Value,L,LeftEval),
	tree_eval(Value,R,RightEval),
	Op = '-',
	Eval is LeftEval - RightEval.

tree_eval(Value,tree(L,Op,R),Eval):-
	tree_eval(Value,L,LeftEval),
	tree_eval(Value,R,RightEval),
	Op = '*',
	Eval is LeftEval * RightEval.

tree_eval(Value,tree(L,Op,R),Eval):-
	tree_eval(Value,L,LeftEval),
	tree_eval(Value,R,RightEval),
	Op = '/',
	Eval is LeftEval / RightEval.