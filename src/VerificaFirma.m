function [Validar, hashEnmascarado, hashArchivo] = VerificaFirma(archivo, firma, n, exponente)
%Creamos el resumen del archivo con MD5 (Simulink.getFileChecksum())
hashArchivo = Simulink.getFileChecksum(archivo);

%Declaramos el exponente y el módulo como simbólicos
e = sym(exponente);
modulo = sym(n);

% Podemos crear una variable para pasar el valor del hash en hexadecimal a decimal:
%   -> firmaDec = sym(strcat('0x', firma));
% Pero esto se puede hacer directamente sin necesidad de crear otra variable

% Desciframos elevando la firma al exponente e (clave pública) módulo n (público) y 
% recuperamos M
M = powermod(sym(strcat('0x', firma)), e, modulo);

% La firma entre 2^128 me dará:
% El cociente -> g  pordríamos hacerlo: g = floor(z/x);
% y el resto -> h pordríamos hacerlo: h = mod(z,x);
% Pero lo obtenemos con la función quorem de una manera más simplificada:
[g, h] = quorem(M, sym(2)^128);

% Obtenemos el hash oculto
m = mod(g * h, sym(2)^128);

% Pasamos el valor oculto obtenido a hexadecimal
hashEnmascarado = dec2hex(m);

% Creamos el boolean de la función:
if hashArchivo == hashEnmascarado
    Validar = true;
else
    Validar = false;
end

end
