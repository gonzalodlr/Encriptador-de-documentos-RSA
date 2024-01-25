function  [n,e,d] = claveRSA1(bits)
% Antes de empezar, voy a explicar porque realizo todo este proceso del
% principio, la funcion randprimo() tiene como variables de entrada un
% número, que mostrará como resultado un número primo de tantas
% cifras como indiquemos en la función.
% Como en la práctica tenemos que indicar una clave RSA de entre 200 y 256
% bits, para crear un módulo correspondiente a esos bits tenemos que
% realizar una serie de ajustes a nuestra función de claveRSA1:

% Es por esto por lo que defiremos el rango del tamaño que tendrá nuestro módulo (ya que tiene que ser del tamaño de bits
% que se indica en la claverRSA1)
max = sym(2)^bits-1;        % Definimos el número máximo que podría ser el módulo de nuestra clave 
min = sym(2)^(bits-1)+1;    % Definimos el número mínimo que podría ser el módulo de nuestra clave 

% Definimos las cifras que corresponderán a los primos aleatorios de
% nuestra claveRSA1:
minimo = string(min);           % Pasamos el número mínimo de nuestra clave a string, para posteriormente ayudarnos a calcular la longitud
cifras = strlength(minimo);     % Definimos la cantidad de cifras que tiene
% De esta manera ya sabemos cuantas cifras tendrá nuestro módulo

% Calculamos dos primos para construir el módulo de nuestra clave:
% Antes de nada, dividiremos la cantidad de cifras entre 2, 
% ya que al multiplicar las cifras, se añaden mas en el resultado, ejemplo:
% Si multiplico 10^3 * 10^4, el resultado será 10^7
b=floor(cifras/2); 

p=randprimo_10(b);
q=randprimo_10(b+1);
% Obtenemos el módulo:
n=p*q;

% Realizamos una condición para que sí el número calculado en el módulo,
% no está en el rango de las posibles números, calcule otro módulo que si
% que lo esté:
while(n < min || n > max) 
p=randprimo_10(b);
q=randprimo_10(b+1);
n=p*q;
end
% Función de Carmichael:
lambda=lcm(p-1,q-1);
% Calculamos un exponente primo:
e=sym(2)^32+1; 
% Comprobamos que el MCD sea igual a 1:
while gcd(e,lambda) > 1 
    e=nextprime(e);     % devuelve el menor primo mayor o igual a e
end
% La Clave RSA será:
d=powermod(e,-1,lambda);
end

