data1=input('Input the data bits')
divisor=input('Input the divisor')
data2=[data1, zeros(1,length(divisor)-1)]
smaller_block=data2(1:length(divisor))
dividend=xor(smaller_block,divisor)

for i=length(divisor) + 1:length(data2)
    smaller_block=[dividend(2:length(divisor)),data2(i)]
    if smaller_block(1) ==1
        dividend=xor(smaller_block,divisor)
    else
        dividend=smaller_block
    end
end

remainder=dividend(2:length(divisor))
codeword=[data1,remainder]

%Decoding (Receiving End)
received_data=input('Enter the received bits')
data2=received_data
smaller_block=data2(1:length(divisor))
dividend=xor(smaller_block,divisor)

for i=length(divisor)+1:length(data2)
    smaller_block=[dividend(2:length(divisor)),data2(i)]
    if smaller_block(1)==1
        dividend=xor(smaller_block,divisor)
    else
        dividend=smaller_block
    end
end

remainder=dividend(2:length(divisor))
if remainder==0
    disp('No Error')
else
    disp('Error')
end
