function update_graph(X)
    global points;
    points = [points; X(1) X(2)];
    subplot(2,2,rows(points));
    plot(X(1), X(2), "or");
endfunction;
