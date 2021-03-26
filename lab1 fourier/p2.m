Fs = 100;               % Frecuencia de muestreo
Ts = 1/Fs;              % Periodo de muestreo
p = 1;                  % pulso
l = 3;                  % Limites
t = -l:Ts:l;            % Dominio
x = (t > -p) & (t < p); % Funcion

omegaFFT = t*Fs;        % Dominio de la transformada
X = fft(x)/Fs;          % Transformada rapida

sa = inline('(sin(x))./(x)','x');  % Funcion
omega_2 = [-l*2*pi:Ts:pi*l*2];     % Dominio de la transformada analitica
y = 2*p*sa(p*omega_2);             % Transformada analitica

%Graficas
subplot(1,2,1);
stem(omegaFFT, abs(fftshift(X)));
axis([-20 20 -2.5 2.5]);
title('Transformada Rapida de Fourier FFT');
xlabel('\omega');
ylabel('X(\omega)');
grid;

subplot(1,2,2);
plot(omega_2,y,'-r');
axis([-20 20 -2.5 2.5]);
title('Transformada de Fourier Analitica');
grid;xlabel('\omega');
ylabel('X(\omega)');