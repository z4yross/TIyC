#Definición de la función pulso rectangular x(t).
Fs = 100;               % Frecuencia de muestreo
Ts = 1/Fs;              % Periodo de muestreo
p = 1;                  % pulso
l = 3;                  % Limites
t = -l:Ts:l;            % Dominio
x = (t > -p) & (t < p); % Funcion

# Definición de la transformada X(\omega).
omega = t * Fs;
X = fft(x);

# Definición de H(\omega)
wc0 = 4;
wc1 = 20; 
n = length(X);
H = zeros(1, n);
for i = wc0:wc1  % Dejar las frecuencias en medio
  H(i) = 1;
  H(n - i + 1) = 1;
endfor
W(wc1) = 0;
H(wc1 + 1) = 1;

#Producto entre H y X para obtener la señal filtrada en frecuencia.
Y = H .* X;
#Transformada inversa para hallar la señal deformada en el tiempo.
y = ifft(Y);

#Gráficas de las señales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t, x, y, omega, abs(X), abs(Y), H, 'Señal Filtrada PasaBanda ideal Y(\omega)');