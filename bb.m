% Main function, calculates the minimum solution made of integers
function [ret1, ret2, ret3] = bb(f, A, B, Aeq, Beq, lb, ub)

    global num_variables;
    flag_int = 1;

    [X, v] = linprog(f, A, B, Aeq, Beq, lb, ub);

    for i =  1:num_variables
        % If not integer
        if ((!isnan(v)) && (!~mod(X(i),1)))
            flag_int = 0;
            var_val = floor(X(i));
            var_index = i;
        endif;
    endfor;

    disp(flag_int);

    % If all elements integer
    if (flag_int == 1)
        if (isnan(v))
            ret1 = NA;
            ret2 = 1;
            ret3 = inf;
        else
            ret1 = X;
            ret2 = 1;
            ret3 = v;

            update_graph(X);
        endif
    else
        printf("I am not an integer: ");
        lb1 = lb;
        lb2 = lb;
        ub1 = ub;
        ub2 = ub;

        lb1(var_index) = var_val+1;

        ub2(var_index) = var_val;

        printf("varval")

        [X1, i1, v1] = bb(f, A, B, Aeq, Beq, lb1, ub1);
        [X2, i2, v2] = bb(f, A, B, Aeq, Beq, lb2, ub2);

        printf("passed almost all")

        if (v1 < v2)
            ret1 = X1;
            ret2 = i1+i2;
            ret3 = v1;
        else
            ret1 = X2;
            ret2 = i1+i2;
            ret3 = v2;
        endif;
    endif;
    return;
endfunction;

