pkg load optim

lb = [];
ub = [];
Aeq = [];
Beq = [];

% Inputs
f = input("Enter the coefficients of the function to minimize in\
 the form of a column vector: ")
A = input("Enter the coefficients of the right hand side of the\
 constraints in the form of an array with one constraint per line: ")
B = input("Enter the left hand side of the constraints in the form of\
 a column vector: ")

% Number of variables = number of coefficients in f
num_variables = numel(f);

% Assume all variables >= 0
lb = zeros(num_variables, 1);
ub = inf*ones(num_variables, 1);

function retval = bb(f, A, B, Aeq, Beq, lb, ub)
    [v, X] = linprog(f, A, B, Aeq, Beq, lb, ub);
    flag_int = 1;

    for i =  0:num_variables
        if mod(X(i),1)
            flag_int = 0;
            var_val = floor(X(i));
            var_index = i;
        endif;
    endfor;

    if flag_int
        retval = [v, X];
    endif;

    lb1 = lb;
    lb2 = lb;
    ub1 = ub;
    ub2 = ub;

    lb1[var_index] = var_val+1;

    ub2[var_index] = var_val;

    [v1, X1] = bb(f, A, B, Aeq, Beq, lb1, ub1);
    [v2, X2] = bb(f, A, B, Aeq, Beq, lb2, ub2);

    if v1 < v2
        retval = [v1, X1];

    retval = [v2, X2];
endfunction;

[v, X] = bb(f, A, B, Aeq, Beq, lb, ub)

