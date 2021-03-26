pkg load signal;

function X = stf(t, T, N, x, w0)
  a0 = (1 / T) * integral(@(a) x(a), -T / 2, T / 2);     % Encontrar el primer coeficiente                                      
  X = a0;                                                % Se agrega el primer termino a la serie
  for k = 1:N
    ak = (2 / T) * integral(@(a) x(a) .* cos(k*w0*a), -T / 2, T / 2);   % El k-esimo coeficiente a de la serie
    bk = (2 / T) * integral(@(b) x(b) .* sin(k*w0*b), -T / 2, T / 2);   % El k-esimo coeficiente b de la serie
    X += ak * cos(k*w0*t) + bk * sin(k*w0*t);                           % Se agrega el k-esimo termino a la serie
  endfor
endfunction

N = 10;                    % Truncado en k = N
Fs = 100;                  % Frecuencia de muestreo
T = 2;                     % Periodo
w = 2 * pi / T;            % Frecuencia angular
l = 4;                     % Limites
t = -l:1/Fs:l;             % Dominio
A = 1;                     % Amplitud
x = @(t) A * square(w*t);  % Funcion periodica
X = stf(t, T, N, x, w);    % Serie trigonometrica de fourier

plot(t, x(t), t, X);
axis([-l l -A - A/2 A + A/2]);
title("Serie trigonometrica de fourier");
xlabel("t");
ylabel("x(t)");
legend('funcion', strcat('Serie truncada en N = ', num2str(N)));
grid;

