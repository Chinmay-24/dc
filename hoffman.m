SYM=input('Enter the symbols')
PROB=input('Enter the probabilies')
[DICT,AVGLEN]=huffmandict(SYM,PROB)
SIG=input('Enter the signal to be transmitted')
ENCO=huffmanenco(SIG, DICT)
DECO=huffmandeco(ENCO,DICT)
entropy=0
for i=1:length(PROB)
    entropy=entropy+PROB(i)*log2(1/PROB(i))
end
efficiency=entropy/AVGLEN
redundancy=1-efficiency
