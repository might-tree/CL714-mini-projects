function p = detectPeriod(tail,maxP)
    tol = 1e-6;
    N = length(tail);
    p = -1;
    for per = 1:maxP
        if N < 2*per, continue; end
        last = tail(end-per+1:end);
        prev = tail(end-2*per+1:end-per);
        if max(abs(last-prev)) < tol
            p = per;
            return;
        end
    end
end
