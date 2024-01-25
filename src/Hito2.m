%   Trateremos de verificar las 5 firmas cargadas desde FirmasHito2,
%   y mostraremos una tabla con los datos de su validez, la m enmascarada y
%   su hash

% Limpiamos el workspace y el command window
clear
clc

% Cargamos los datos
load('datos.mat');

% Indicamos el archivo
archivo = 'Calendario.pdf';
fprintf('Archivo de entrada: %s\n', archivo);

% Creamos la Tabla
size = [5 4];
tipos={'double','string','string','string'};
nombre = {'Firmas','Validez','ValorEnmascarado','Hash'};
T = table('Size',size,'VariableTypes',tipos,'VariableNames',nombre);

% Completamos la Tabla
for i=1:5
[Validez, ValorEnmascarado, Hash] = VerificaFirma(archivo,FirmasHito2{i},keyAuto.modulo,keyAuto.exponente);
T(i,:) = {i,Validez,ValorEnmascarado,Hash};
end

% Mostramos la Tabla
disp(T)