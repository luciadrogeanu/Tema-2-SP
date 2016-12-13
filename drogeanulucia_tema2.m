%semnal dreptunghiular x de perioada 40s, durata 9s, factor de umplere
%9/T*100
T=40
w0=(2*pi)/T
t=0:0.1:100
x=square(w0*t, 9/T*100)


N=25
%C=matricea coeficientilor pe care o egalam initial cu zero
C=zeros(size(2*N+1))
%x2 va fi semnalul reconstruit
x2=0
%for pt calculul coeficientilor de la -25 la 25
for k=-N:N
    %integrala de la 0 la 9 unde semnalul este 1
    fun2=@(t) 1.*exp(-1j*k*w0*t)
    %integrala de la 9 la 40 unde semnalul este -1
    fun3=@(t) (-1).*exp(-1j*k*w0*t)
    %formula de calcul a coeficientilor (integrala pe o perioada
    C(k+N+1)=1/T*(integral(fun2, 0, 9)+integral(fun3, 9, 40))
    re=real(C(k+N+1))
    im=imag(C(k+N+1))
    %se pun coeficientii in matrice
    C(k+N+1)=re+1j*im
    %semnalul va fi suma modulelor coeficientilor
    x2=x2+real(C(k+N+1)*exp(1j*k*w0*t))
end

%reprezentarea grafica a spectrului de amplitudine
subplot(2, 1, 1)
stem((-N:N), abs(C)); title('Spectru de amplitudini');
subplot(2, 1, 2); 
%reprezentarea semnalului initial
plot(t, x, '-')
hold on
%reprezentarea semnalului reconstruit
plot(t, x2, '.'); title('Semnalul reconstruit');
hold off