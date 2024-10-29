clc;
clear;
close all;

%% input data
%parameter
fs=8000; f1=1000; f2=2500; N=256; AMP=16384;
%out_file = 'fir_input.inc';

% generate input discrete time serial x_tmp
n = 0:(N-1);
x_tmp = sin(2 * pi * f1 * n / fs) + sin(2 * pi * f2 * n / fs);
% normalize the value
x = round(x_tmp / max(abs(x_tmp)) * AMP);

% generate input continuous value x_con for plot
n_con = 0 : 0.1 :(N-1);
x_con = sin(2 * pi * f1 * n_con / fs) + sin(2 * pi * f2 * n_con / fs);
% normalize the value
x_con = round(x_con / max(abs(x_con)) * AMP);

% frequnce analysis for x
z = fft(x);
x_amp_feq_mod = abs(z);
x_amp_feq = x_amp_feq_mod / (N / 2);   %换算成实际的幅度
x_amp_feq(1) = x_amp_feq(1) / 2;
freq = ((1 : N) - 1) * fs / N;     %换算成实际的频率值

x_phase_feq = angle(z);              %计算相位
x_phase_feq = x_phase_feq * 180 / pi;  %换算为角度

% plot figure for x
h = figure;
set(h,'position',[100 100 1000 600]);
subplot(4,1,1); plot(n_con, x_con); xlim([0,N]); title('输入模拟信号');
subplot(4,1,2); stem(n, x, 'MarkerSize', 12, 'Marker', '.'); xlim([0,N]); title('输入时域离散信号');
subplot(4,1,3); plot(freq(1:N/2), x_amp_feq(1:N/2)); xlim([0, fs/2]); title('输入信号幅频特性');
subplot(4,1,4); plot(freq(1:N/2), x_phase_feq(1:N/2)); xlim([0, fs/2]); title('输入信号相频特性');