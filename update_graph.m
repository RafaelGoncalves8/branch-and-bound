function update_graph(X, A, B, v)
    global points;

    X_lim = [];
    Y_lim = [];

    C = [];
    if (numel(X) <= 2)
        for i = 1:rows(A)
            Y_lim = [Y_lim;B(i)/A(i,2)];
            X_lim = [X_lim;B(i)/A(i,1)];
        endfor

        t = 0:0.1:max(X_lim);

        for i = 1:rows(A)
            C = [C; ((-A(i,1)/A(i,2))*t + B(i)/A(i,2))];
        endfor

        points = [points; X(1) X(2)];
        subplot(2,2,rows(points));
        plot(X(1), X(2), "or", t, C, "b");
        ylim([0 max(Y_lim)]);
        title(strcat('x1 =  ', num2str(X(1)), ' ;  x2 =  ', num2str(X(2)), ' ; v =  ', num2str(v)));
    endif
endfunction;
