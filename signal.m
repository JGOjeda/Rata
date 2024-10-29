% t = 0:1/2000:2-1/2000;
% q = chirp(t-2,4,1/2,6,'quadratic',100,'convex').*exp(-4*(t-1).^2);
% plot(t,q)

clear all
close all 

t = 0:1e-5:1e-3;
y = abs(0.2 * sin(2*pi*2e3*t));
t2 = 0:1e-5:1e-3;
y2 = abs(0.2 * sin(3*pi*2e3*t));
 plot(t,y)
 hold on 
plot(t2,y2)


[r3,l]= xcorr(y, 'normalized');
 figure 
 plot(l,r3)

 [r4,l4]= xcorr(y2, y, 'normalized');
 hold on  
 plot(l4,r4)

 [r5,l5]= xcorr(y2,y2, 'normalized');
 hold on  
 plot(l5,r5)