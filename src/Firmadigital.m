function [y, m] = Firmadigital(archivo, n, clavePrivada)

% Creamos el resumen del archivo con MD5 (Simulink.getFileChecksum())
m = Simulink.getFileChecksum(archivo);

% Convertimos el hash(en caracteres -> hexadecimal) a hash(en decimal)
%            -> hash = sym(strcat('0x', m));
% Nota: No lo realizo porque se puede hacer directamente

% Generamos un entero aleatorio impar g de 64 bits
g = randimpar();

% Como es impar, tiene inverso modulo 2^128
g1 = powermod(g, -1, sym(2)^128);

% Calculamos h = g^−1· m mod 2^128
h = mod(g1 * sym(strcat('0x', m)), sym(2)^128);

% M = g · 2^128 + h
M = g * sym(2)^128 + h;

% Obtenemos la firma digital, f = M^d mod n
f = powermod(M, clavePrivada, n);

% Pasamos el valor de la firma a hexadecimal
y = dec2hex(f);
end
