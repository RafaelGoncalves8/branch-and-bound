pkg load optim

lb = [];
ub = [];
Aeq = [];
Beq = [];
points = [];

% Inputs
f = input("Enter the coefficients of the function to minimize in\
 the form of a column vector:\n")
A = input("Enter the coefficients of the right hand side of the\
 constraints in the form of an array with one constraint per line:\n")
B = input("Enter the left hand side of the constraints in the form of\
 a column vector:\n")

assert (rows(f) == columns(A));
assert (rows(A) == rows(B));

% Number of variables = number of coefficients in f
num_variables = numel(f);

% Assume all variables >= 0
lb = zeros(num_variables, 1);
ub = inf*ones(num_variables, 1);

% Call to the function Branch&Bound
[X, i, v] = bb(f, A, B, Aeq, Beq, lb, ub);

printf("Variables values:\n")
disp(X)
printf("Iterations: ")
disp(i)
printf("Value of the optimal solution: ")
disp(v)

