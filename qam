N=1024;%Number of Bits
M=16;%Modulation Order 16
data = randi([0 M-1]); %Message information
s = qammod(data,M);

%AWGN for constellation points
SNR=20;
r = awgn(s,SNR,'measured');
bit_rate = 10.^3;
f=bit_rate;
Tb= 1/bit_rate;
t= 0:(Tb/1000):Tb;

%Transmitted Signal Waveform
TxSig = [];
for l=1:length(data)
    Tx = real(s(1))*cos(2*pi*f*t) - imag(s(1))*sin(2*pi*f*t);
    TxSig = [TxSig Tx];
end

RxSig = awgn(TxSig,SNR,'measured');
figure(1)
subplot(3,1,1);
stairs(data);
grid minor;
ylim([-0.5,M-0.5]);
xlim([0,N]);
title('Message Signal');
subplot(3,1,2);
plot(TxSig);
grid minor;
title('16-QAM Modulated Signal');
xlim([0,N*10^3+N]);
subplot(3,1,3);
plot(RxSig);
grid minor;
title('16-QAM Modulated Signal AWGN');
xlim([0,N*10^3+N]);
 %Constellation Diagram of the Rx
 scatterplot(r);
 grid minor;
 title('Constellation Diagram of 16-QAM')
