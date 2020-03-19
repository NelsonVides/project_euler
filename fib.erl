-module(fib).
-compile([export_all]).

% A common strategy for solving problems
% 1. divide the problem in smaller pieces
% 2. solve the pieces one by one
% 3. put them together

% In this exercise we need:
% The sum of the even terms of the fibonnaci sequence up to 4M, so:
% 1. get all the fibonnaci terms
% 2. filter the even ones
% 2. compute the sum

% Step by step
ex1() ->
    Generated = generate(4000000),
    Filter = lists:filter(fun(X) -> X rem 2 == 0 end, Generated),
    _Result = lists:sum(Filter).

% Merge steps 2 and 3
ex2() ->
    FibbTerms = generate(4000000),
    lists:sum([ X || X <- FibbTerms, X rem 2 == 0 ]).

% Merge steps 1 and 2
ex3() ->
    FibEvenNumbers = generate_even_only(4000000),
    lists:sum(FibEvenNumbers).

% Merge all steps
ex4() ->
    all_at_once(1, 1, 4000000, 0).

all_at_once(S, _, Limit, Acc) when S > Limit -> Acc;
all_at_once(S, B, Limit, Acc) when S rem 2 == 0 -> all_at_once(B, S + B, Limit, S + Acc);
all_at_once(S, B, Limit, Acc) -> all_at_once(B, S + B, Limit, Acc).

generate(Limit) -> generate(1, 1, Limit).
generate(S, _, Limit) when S > Limit -> [];
generate(S, B, Limit) -> [S | generate(B, S + B, Limit)].

generate_even_only(Limit) -> generate_even_only(1, 1, Limit).
generate_even_only(S, _, Limit) when S > Limit -> [];
generate_even_only(S, B, Limit) when S rem 2 == 0 -> [S | generate_even_only(B, S + B, Limit)];
generate_even_only(S, B, Limit) -> generate_even_only(B, S + B, Limit).
