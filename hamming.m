parity_matrix=[0.1,0.2,0.3,0.4]
generator_matrix=[eye(4),parity_matrix]
data_matrix=input('Enter 4 bit data in a single row')
code_matrix=mod(data_matrix*generator_marix,2)
parity_check_matrix=[parity_matrix'eye(3)]
H_transpose=parity_check_matrix'
received_bits=input('Enter the received bits in a row')
syndrome=mod(receieved_bits*H_transpose,2)
if syndrome==0
    decoded_bits=received_bits(1:4)
else
    for i=1:7
        if syndrome==H_transpose(i,:)
            error_position=i
            break
        end
         received_bits(error_position)=xor(received_bits(error_position),1)
         decoded_bits=received_bits(1:4)
    end
