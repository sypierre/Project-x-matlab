function idxpn = idxsampling(IDXP,IDXN, n ,randd )
% 1/2 pos - 1/2 negs idx
l1 = length(IDXP); 
l2 = length(IDXN);
if randd
while true
    
    RPS = round(rand(1,n)*l1);
    RNS = round(rand(1,n)*l2);
    if ~sum(RPS ==0 ) && ~ sum(RNS == 0)
        break;
    end
end
else
    RPS = 1 : n;
    RNS = 1 : n;
end

idxpn = [IDXP(RPS); IDXN(RNS)];

end

    

