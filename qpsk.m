data=[0 1 0 1 1 1 0 0 1 1];
figure(1)
stem(data,'LineWidth',3),grid on;
title('Information before Transmitting');
axis([0 11 0 1.5]);
data_NRZ=2*data-1;
s_p_data=reshape(data_NRZ,2,length(data)/2);
br=10.^6;
f=br;
T=1/br;
t=T/99:T/99:T;
y=[];
y_in=[];
y_qd=[];
for(i=1:length(data)/2)
    y1=s_p_data(1,i)*cos(2*pi*f*t);
    y2=s_p_data(2,i)*sin(2*pi*f*t);
    y_in=[y_in y1];
    y_qd=[y_qd y2];
    y=[y y1+y2];
end
Tx_sig=y;
tt=T/99:T/99:(T*length(data)/2);
figure(2)
subplot(3,1,1);
plot(tt,y_in,'LineWidth',3),grid on;
title('wave form for inphase component in QPSK modulation')
xlabel('time(sec)');
ylabel('amplitude(volt0)');
subplot(3,1,2);
plot(tt,y_qd,'LineWidth',3),grid on;
title('wave form for quadrature component in QPSK modulation');
xlabel('time(sec)');
ylabel('amplitude(volt0)');
subplot(3,1,3);
plot(tt,Tx_sig,'r','LineWidth',3),grid on;
title('QPSK modulated signal(sum of inphase and Quadrature phase signal)');
xlabel('time(sec)');
ylabel('amplitude(volt0)');
Rx_data=[];
Rx_sig=Tx_sig;
for(i=1:1:length(data)/2)
    z_in=Rx_sig((i-1)*length(t)+1:i*length(t)).*cos(2*pi*f*t);
    z_in_intg=(trapz(t,z_in))*(2/T);
    if(z_in_intg>0)
        Rx_in_data=1;
    else
        Rx_in_data=0;
    end
    z_qd=Rx_sig((i-1)*length(t)+1:i+length(t)).*sin(2*pi*f*t);
    Z_qd_intg=(trapz(t,Z_qd))*(2/T);
    if (Z_qd_intg>0)
    Rx_qd_data=1;
    else
    Rx_qd_data=0;
    end
    Rx_data=[Rx_data Rx_in_data Rx_qd_data];
end
figure(3)
stem(Rx_data,'LineWidth',3)
title('information after recieving');
axis([0 11 0 1.5]), grid on;
clc;clear all; close all;
x=input('enter digital input information(pair of bits)=');
N=length(x);
disp('Binary input information at transmitter:');
disp(x);
NRZ=2*x-1;
data=reshape(NRZ,2,N/2);
fc=10.^3;
Tb=1/fc;
t=0:(Tb/99):Tb;
mod=[];
Ac=1;
In_phase=[];
Quadrature=[];
for (r=1:N/2)
    In=data(1,r)*Ac*cos(2*pi*fc*t);
    Qd=data(2,r)*Ac*sin(2*pi*fc*t);
    Quadrature=[Quadrature Qd];
    mod=[mod In+qd];
end    
M=4;
const=[];
for (n=1:N/2)
    if data(1,n)==-1 && data(2,n)== -1
        C=exp(-i*((2*pi*0)/M))
    elseif data(1,n)==-1 && data(2,n)== 1
        C=exp(-i*((2*pi*1)/M))
    elseif data(1,n)==1 && data(2,n)== -1
        C=exp(-i*((2*pi*2)/M))
    elseif data(1,n)==1 && data(2,n)== 1
        C=exp(-i*((2*pi*3)/M))
    end
    const=[const C];
end
figure('Name','QPSK Modulation','NumberTitle','off');
subplot(2,1,1);
stairs(NRZ);grid minor;title('QPSK Modulated Signal');ylim([-2,2]);
scatterplot(const,[],[],'r*');grid minor
