function plot_4(t,x,y,omega,X,Y,H,title_filter)
  %plot 1
  subplot(3,2,1);
  plot(t,x,'b');
  title('Señal Pulso Rectangular x(t)');
  axis([-3 3 -0.2 1.4]); 
  xlabel('t');
  ylabel("x(t)");

  %plot 2
  subplot(3,2,2);
  stem(omega,fftshift(X),"r");
  axis([-50 50 -200 200]);
  title('Transformada de Fourier X(\omega)');
  xlabel('\omega');
  ylabel('X(\omega)');

  %plot 3
  subplot(3,2,6);
  stem(omega,fftshift(Y),"r");
  axis([-50 50 -200 200]);
  title(title_filter);
  xlabel('\omega');
  ylabel('X(\omega)');

  %plot 4
  subplot(3,2,5);
  plot(t,y,'b');
  title('Señal deformada y(t)');
  xlabel('t');
  ylabel("x(t)");
  
  %plot 5
  subplot(3,2,[3 4]);
  stem(omega,fftshift(H),'g');
  axis([-50 50 -2 2]);
  title('filtro H(\omega)');
  xlabel('\omega');
  ylabel("H(\omega)");
endfunction