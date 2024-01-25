function Y = randprimo_10(cifras)
%   randprimo_10 genera un numero primo pseudoaleatorio comn tantas cifras
%   como se indica en esta misma variable que, naturalmente, debe ser
%   un entero positivo.

%   Inicializamos el generador de numeros aleatorios de MATLAB en base al
%   tiempo del reloj de la computadora en este momento. Esto resulta en 
%   diferentes sequencias de numeros aleatorios en cada llamada rng().
rng('shuffle');

Y=0;
B=sym(1);
for i=1:cifras-1
    Y=Y+randi([0, 9])*B; %con randi([0, 9]) generamos un entero pseudoaleatorio entre 0 y 9
    B=10*B;
end
Y=Y+randi([1, 9])*B;
%Devuelve el siguiente numero primo que es > o = que Y
Y=nextprime(Y);
end

