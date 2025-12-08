for go=1:12
    go
n=1e4;
SNR_dB=0:2:14;
pulse_Width=1;
data=randi([0 1],n,1);
del=0.01;
t=0:del:pulse_Width;
rect_pulse=ones(size(t));
BER=zeros(length(SNR_dB),1);
for snr_idx =1:length(SNR_dB)
    tx_signal=[];
    for i=1:n
        if data(i)==1
            tx_signal =[tx_signal;rect_pulse'];
        else
            tx_signal=[tx_signal;zeros(size(rect_pulse'))];
        end
    end
    
    SNR=10^(SNR_dB(snr_idx)/10)*pulse_Width/del;
    noise_power=1/(2*SNR);
    noise=sqrt(noise_power)*randn(length(tx_signal),1);
    rx_signal=tx_signal+noise;
    
    matched_filter=rect_pulse;
    filtered_signal=conv(seqreverse(rx_signal),matched_filter,'valid');
    sample_interval=round(length(filtered_signal)/n);
    sampled_signal=filtered_signal(1:sample_interval:end);
    estimated_bits=sampled_signal>0.5;
    num_errors=sum(estimated_bits~=data);
    BER(go,snr_idx)=num_errors/n;
end
end
figure;
semilogy(SNR_dB,mean(BER),'b-o');
grid on;
xlabel('SNR(dB)')
ylabel('Bit error rate (BER)');
title('BER vs. SNR for Rectangular Pulse modulated Binary data')
