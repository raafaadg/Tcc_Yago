close all
clear 
clc
%%
%Assumindo que o primeiro valor representa o número 11
p=.2;
x=[2 3 5 10];
pmf= p*((1-p).^(x-1));
pmf= (x>0).*(x==floor(x)).*pmf;
pg_exato=sum(pmf)


%% Simulação com 10e3 V.A.
r=rand(10e3,1);
X=ceil(log(1-r)/log(1-p));
prob = arrayfun(@(x)length(find(X==x)), unique(X)) / length(X);
pg1 = sum(prob([2 3 5 10]))
figure
hist(X)
%% Simulação com 10e5 V.A.
r=rand(10e5,1);
X=ceil(log(1-r)/log(1-p));
prob = arrayfun(@(x)length(find(X==x)), unique(X)) / length(X);
pg2 = sum(prob([2 3 5 10]))
figure
hist(X)
%% Simulação com 10e7 V.A.
r=rand(10e7,1);
X=ceil(log(1-r)/log(1-p));
prob = arrayfun(@(x)length(find(X==x)), unique(X)) / length(X);
pg3 = sum(prob([2 3 5 10]))
figure
hist(X)