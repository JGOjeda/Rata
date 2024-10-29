%correlacion 
clear all 
Z1={};
Z2={};

Z1=cell2mat(Z1);
Z2=cell2mat(Z2);

[r,p]= xcorr(Z1,Z2)