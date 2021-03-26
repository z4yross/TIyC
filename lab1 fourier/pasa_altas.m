#Definición de la función pulso rectangular x(t).
Fs = 100;               % Frecuencia de muestreo
Ts = 1/fs;              % Periodo de muestreo
p = 1;                  % pulso
l = 3;                  % Limites
t = -l:Ts:l;            % Dominio
x = (t > -p) & (t < p); % Funcion

# Definición de la transformada X(\omega).
omega = t * Fs;
X = fft(x);

# Definición de H(\omega)
wc = 4;
n = length(X);
H = ones(1, n);
for i = 1:wc  % Quitar las frecuencias menores
  H(i) = 0;
  H(n - i + 1) = 0;
endfor
H(wc + 1) = 0;

#Producto entre H y X para obtener la señal filtrada en frecuencia.
Y = H .* X;
#Transformada inversa para hallar la señal deformada en el tiempo.
y = ifft(Y);

#Gráficas de las señales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t, x, y, omega, X, Y, H, 'Señal Filtrada PasaAltas ideal Y(\omega)');