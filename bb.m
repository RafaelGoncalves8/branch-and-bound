% Main function, calculates the minimum solution made of integers
function retval = bb(f, A, B, Aeq, Beq, lb, ub)

    global num_variables;

    [v, X] = linprog(f, A, B, Aeq, Beq, lb, ub);
    flag_int = 1;

    % print("calculated first simplex")

    for i =  0:num_variables
        if mod(X(i,0),1)
            flag_int = 0;
            var_val = floor(X(i,0));
            var_index = i;
        endif;
    endfor;
    % print("calculated variables as int or not")

    if flag_int
        retval = [v, X];
    else
        lb1 = lb;
        lb2 = lb;
        ub1 = ub;
        ub2 = ub;

        lb1(var_index,0) = var_val+1;

        ub2(var_index,0) = var_val;

        % print("about to calculate simplex")

        [v1, X1] = bb(f, A, B, Aeq, Beq, lb1, ub1);
        [v2, X2] = bb(f, A, B, Aeq, Beq, lb2, ub2);

        % print("calculated simplexes")
        if (v1 < v2)
            retval = [v1, X1];
        endif;

        retval = [v2, X2];
    endif;
endfunction;

