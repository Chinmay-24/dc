N= 1e4;%Number of bits
SNR_dB = 0:5:20;%SNR values in dB
pulse_width = 1;
%Generate random binary data
data = randi([0,1], N, 1);
%Define the ractangular pulse
t=0:0.01:pulse_width;
rect_pulse = ones(size(t));
%Initialize BER vector
BER = zeros(length(SNR_dB), 1);
for snr_idx = 1:length(SNR_dB)
%Modulate binary data
tx_signal = [];
for i =1:N
if data(i) == 1
tx_signal = [tx_signal; rect_pulse'];
else
tx_signal = [tx_signal;zeros(size(rect_pulse'))];
end
end
%Add AWGN
SNR = 10^(SNR_dB(snr_idx)/10);
noise_power = 1 / (2 * SNR);
noise = sqrt(noise_power) *randn(length(tx_signal), 1);
rx_signal = tx_signal + noise;
%Matched Filter
matched_filter = rect_pulse;
sampled_signal = filtered_signal(1:sample_interval:end);
%Decision (Threshold = 0.5)
estimated_bits = sampled_signal >0.5;
%compute BER
num_errors = sum(estimated_bits ~=data);
BER(snr_idx) = num_errors /N;
end
% Plot BER vs SNR
figure;
semilogy(SNR_dB, BER, 'b-o');
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate(BER)');
title('BER vs SNR for rectangular pulse modulated binary data')
