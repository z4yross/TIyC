clear

fm = 100;                  % Frecuencia de muestreo señal original
T = 2;                     % Periodo
w = 2 * pi / T;            % Frecuencia angular
l = pi;                    % Limites
t = [-l:1/fm:l];           % Dominio
A = 1;                     % Amplitud
m = @(t) A * sin(w * t) + A*2*sin(2*w*t);  % Funcion

#Señal Original Grafica
figure(1);
subplot(5,1,1); 
plot(t,m(t),'b');
grid; 
title('Señal original m(t)');
xlabel("t"),ylabel("m(t)");                               

%----------- MUESTREO -----------

Ts = 2*T;                  % Periodo de muestreo
v_Ts = [-l:1/Ts:l];        % Vector de tiempos para muestreo
ms = m(v_Ts);              % Muestreo

#Señal Muestrada
subplot(5,1,2);
hold on;
stem(v_Ts,ms,'b'); 
plot(t,m(t),'r');
grid; 
title('Señal Muestreada m(Ts)');
xlabel("t"),ylabel("m(Ts)");
hold off;


%----------- CUANTIZACION -----------

mp = max(m(t));
n = 2; 
L = 2^n;
delta = 2 * mp / L;

q=floor(L*((ms+mp)/(2*mp)));   % Asignar el nivel correspondiente a cada valor de la señal muestreada       
i=find(q>L-1);  
q(i)=L-1;                      % Si el nivel es mayor a la mayor nivel se le asigna el mayor nivel        
i=find(q<0); 
q(i)=0;                        % Si el nivel es menor al menor nivel se le asigna el menor nivel
mq=(q*delta) - mp + (delta/2); % Se asigna el nivel a la señal teniendo en cuenta el delta y la amplitud de la señl


subplot(5,1,3); 
hold on;

for j = min(m(t)):delta:max(m(t)) + delta
  line([-4, 4], [j,j], "linestyle", "--", "color", "g");
endfor

stem(v_Ts, mq, 'b');
plot(t,m(t),'r');
title(['Señal Cuantificada en ' num2str(L) ' niveles']);
hold off;

%----------- CODIFICADOR -----------

n = round(log2(max(q) + 1));  % Cantidad de bits necesitada por nivvel
mcod = '';                    % Cadena de niveles en binario

for j = 1:length(q)
  mcod = strcat(mcod, dec2bin(q(j), n)); % Convertir el nivel correspondiente a binario
endfor

bits = ones(1,length(mcod));             % Cadena de bits
for i = 1:length(mcod)
  bits(i) = bits(i)*str2num(mcod(i));
endfor

#---------- FORMATO UNIPOLAR NRZ ----------

bts = [0:.1:length(bits)];      % Dominio para la representacion unipolar

unz = zeros(1, length(bts));

for i = 0:length(bits)-1
  if (bits(i+1) == 1)
    for j = 1:10
      unz((10*i)+j) = 1;       % Se llena todo el bit en el dominio
    endfor
  endif
endfor

subplot(5,1,4);  
plot(bts, unz, 'b'); 
title(['UNIPOLAR NRZ PARA ' mcod]);
axis([0 length(bits) -1.1 1.1]);
grid;

%----------- DECODIFICADOR -----------
% Se convierten los bits a los niveles de cuantizacion correspondiente

mqrl = zeros(1, length(bits)/n);

for j = 1:2:round(length(bits))
  lvl = '';
  for k = j: j+1
    lvl = strcat(lvl, num2str(bits(k)));
  endfor
  mqrl(round(j/2)) = bin2dec(lvl);
endfor

%----------- DEMODULADOR -----------
% Se recupera la señal con la formula del teorema del muestreo e(5.2) simplificada con sinc
n = 2;
L = 2^n;
delta = 2 * mp / L;
mqr=(q*delta) - mp + (delta/2);

f = "";

for i=1:length(mqr)-1
  if(i!=length(mqr)-1)
    f = strcat(f,num2str(mqr(i)),".*sinc((t.-",num2str(i*1/Ts),")./",num2str(1/Ts),").+");
   else
    f = strcat(f,num2str(mqr(i)),".*sinc((t.-",num2str(i*1/Ts),")./",num2str(1/Ts),")");
   endif
endfor

f = inline(f,"t");

subplot(5,1,5); 
fplot(f,[-0.5 , 7.2],'b');
legend("off");
grid; 
title('Señal Demodulada');


