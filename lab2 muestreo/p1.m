fm = 100;                  % Frecuencia de muestreo
T = 2;
w = 2 * pi / T;            % Frecuencia angular
l = pi;                    % Limites
t = [-l:1/fm:l];             % Dominio
A = 1;                     % Amplitud
m = @(t) A * sin(w * t) + A*2*sin(2*w*t);  % Funcion periodica

#Señal Original Grafica
figure(1);
subplot(4,1,1); 
plot(t,m(t),'b');
grid; 
title('Señal original m(t)');
xlabel("t"),ylabel("m(t)");                               


Ts = 2*T;                  %Tiempo muestral 
v_Ts = [-l:1/Ts:l];          %Vector de tiempos para muestreo
ms = m(v_Ts);

#Señal Muestrada
subplot(4,1,2);
hold on;
stem(v_Ts,ms,'b'); 
plot(t,m(t),'b');
grid; 
title('Señal Muestreada ms(t)');
xlabel("t"),ylabel("m(t)");
hold off;

mp = max(m(t));
n = 2; 
L = 2^n;
delta = 2 * mp / L;

q=floor(L*((ms+mp)/(2*mp)));   % Asignar el nivel correspondiente a cada valor de la señal muestreada       
i=find(q>L-1);  
q(i)=L-1;                      % Si el nivel es mayor a la mayor nivel se le asigna el mayor nivel        
i=find(q<0); 
q(i)=0;                        % Si el nivel es menor al menor nivel se le asigna el menor nivel
xq=(q*delta) - mp + (delta/2); % Se asigna el nivel a la señal teniendo en cuenta el delta y la amplitud de la señl

subplot(4,1,3); 
hold on;
stem(v_Ts, xq, 'r');
plot(t,m(t),'b');
stem(v_Ts,ms,'g'); 
grid; 
title(['Señal Cuantificada en ' num2str(L) ' niveles']);
hold off;

function x = e(i, ms, xq)
  x = ms(i) - xq(i);
endfunction

function x = sgn(i, delta)
  if (i < 0)
    x = -delta;
  else 
    x = delta ;
  endif
endfunction

auxSum = 0;
m_st = zeros(1, length(v_Ts));

for i = 1:length(v_Ts)
  auxSum += sgn(e(i* Ts, ms, xq), delta/2)
  m_st(i) = auxSum;
endfor

m_st

subplot(4,1,4); 
hold on;
stem(v_Ts, xq, 'r');
plot(t,m(t),'b');
plot(v_Ts, m_st,'g'); 
grid; 
title(['Señal Cuantificada en ' num2str(L) ' niveles']);
hold off;

