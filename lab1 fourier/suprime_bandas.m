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
wc0 = 4;
wc1 = 20; 
n = length(X);
H = ones(1, n);
for i = wc0:wc1  % Quitar las frecuencias en medio
  H(i) = 0;
  H(n - i + 1) = 0;
endfor
W(wc1) = 1;
H(wc1 + 1) = 0;

#Producto entre H y X para obtener la se�al filtrada en frecuencia.
Y = H .* X;
#Transformada inversa para hallar la se�al deformada en el tiempo.
y = ifft(Y);

#Gr�ficas de las se�ales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t, x, y, omega, X, Y, H, 'Se�al Filtrada suprime banda ideal Y(\omega)');