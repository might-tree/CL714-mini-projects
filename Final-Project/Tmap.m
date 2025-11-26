function xnext = Tmap(x,d1,d2,m)
    if x==d1 || x==d2
        xnext = x; 
%         return;
    elseif x < d1 || x > d2
        xnext = m * x;
    elseif d1 < x && x < d2
        xnext = m * x + (1 - m);
    end
end