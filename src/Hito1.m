%   En este hito trataremos de firmar el archivo Calendario.pdf

% Limpiamos el workspace y el command window
clear
clc

% Cargamos los datos
load('datos.mat');

% Indicamos el archivo
archivo = 'Calendario.pdf';
fprintf('Archivo de entrada: %s\n', archivo);

% Creamos la firma
[y, m] = Firmadigital(archivo, keyAuto.modulo, keyAuto.privada);

% Imprimimos los resultados
fprintf('Archivo de hash: %s\n', m);
fprintf('Firma del archivo: %s\n', y);