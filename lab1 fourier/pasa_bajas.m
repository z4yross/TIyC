#Definici�n de la funci�n pulso rectangular x(t).
Fs = 100;               % Frecuencia de muestreo
Ts = 1/fs;              % Periodo de muestreo
p = 1;                  % pulso
l = 3;                  % Limites
t = -l:Ts:l;            % Dominio
x = (t > -p) & (t < p); % Funcion

# Definici�n de la transformada X(\omega).
omega = t * Fs;
X = fft(x);

# Definici�n de H(\omega)
wc = 4;
n = length(X);
H = zeros(1, n);
for i = 1:wc  % Quitar las frecuencias mayores
  H(i) = 1;
  H(n - i + 1) = 1;
endfor
H(wc + 1) = 1;

#Producto entre H y X para obtener la se�al filtrada en frecuencia.
Y = H .* X;
#Transformada inversa para hallar la se�al deformada en el tiempo.
y = ifft(Y);

#Gr�ficas de las se�ales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t, x, y, omega, X, Y, H, 'Se�al Filtrada PasaBajas ideal ideal Y(\omega)');