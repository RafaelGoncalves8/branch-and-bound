function update_graph(X, A, B, v)
    global points;

    X_lim = [];
    Y_lim = [];

    C = [];
    if (numel(X) <= 2)
        for i = 1:rows(A)
            % constraint doesnt intercept y axis
            if (A(i,2) == 0)
                Y_lim = [0];
            else
                Y_lim = [Y_lim;B(i)/A(i,2)];
            endif
            % constraint doesnt intercept x axis
            if (A(i,1) == 0)
                Y_lim = [0]
            else
                X_lim = [X_lim;B(i)/A(i,1)];
            endif
        endfor

        t = 0:0.1:max(X_lim);

        for i = 1:rows(A)
            if (A(i,2) == 0)
                C = [C; (dirac(B(i)/A(i,1)))*t];
            else
                C = [C; ((-A(i,1)/A(i,2))*t + B(i)/A(i,2))];
            endif
        endfor

        points = [points; X(1) X(2)];
        subplot(2,2,rows(points));
        plot(X(1), X(2), "or", t, C, "b");
        ylim([0 max(Y_lim)]);
        title(strcat('x1 =  ', num2str(X(1)), ' ;  x2 =  ', num2str(X(2)), ' ; v =  ', num2str(v)));
    endif
endfunction;
