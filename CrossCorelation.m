clear all, close all, clc
load rockabilly;
soundsc(y,8000);
vsync=(4090/8192);
v0=(4030/8192);
v1=(4060/8192);
nu = [vsync v0 v1]



N = 65536;

for i = 1:3
    for n = 1:N
         S(i,n) = sin(2*pi*nu(i)*n);
    end
end

[b,a] = butter(10,nu(2)*2,'high');
y_f = filter(b,a,y);
figure
plot(y_f);
xlabel('Sampel, k','FontSize', 24)
ylabel('Amplitud, y(k)','FontSize', 24)

A = [nu(2), nu(1), nu(3), nu(3), nu(2), nu(3), nu(3),  nu(2), nu(1), nu(3), nu(3), nu(2)];
figure
stairs(A)
xlabel('Sekvens, N','FontSize', 24)
ylabel('Normerad Frekvens, \nu','FontSize', 24)
axis([0 13 0.49099 0.5]);



for a = 1:3
    cosync = abs(xcorr(y_f,S(1,:)));
    co0 = abs(xcorr(y_f,S(2,:)));
    co1 = abs(xcorr(y_f,S(3,:)));
end

figure
plot(co1,'g');
hold on
plot(cosync,'r');
hold on
plot(co0,'b');

legend('S_1', 'S_{sync}', 'S_0','FontSize',20)
hold off;
xlabel('Sampel','FontSize', 24)
ylabel('Korskorrelation $$\hat{r}_{XY}(k)$$','Interpreter','Latex','FontWeight','bold','FontSize', 28)
xlim([7e+5 16e+5])