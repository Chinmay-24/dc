SYM=input('Enter the symbols')
PROB=input('Enter the probabilies')
[DICT,AVGLEN]=huffmandict(SYM,PROB)
SIG=randsrc(1000,1,[SYM;PROB]);
ENCO=huffmanenco(SIG, DICT)
DECO=huffmandeco(ENCO,DICT)
entropy=0
for i=1:length(PROB)
    entropy=entropy+PROB(i)*log2(1/PROB(i))
end
entropy
efficiency=entropy/AVGLEN
redundancy=1-efficiency
