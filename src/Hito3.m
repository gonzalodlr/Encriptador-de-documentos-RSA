% Limpiamos el workspace y el command window
clear
clc

% Cargamos los datos
load('datos.mat')

% Cargamos el Cerificado Generado anteriormente
load('micertificado.mat')

% Verificamos la firma
[Validar, hashEnmascarado, hashArchivo] = VerificaFirma('ficherotemporal.bin', firma, keyAuto.modulo, keyAuto.exponente);

% Una vez utilizado el fichero temporal, podremos eliminarlo:
delete 'ficherotemporal.bin'

% Mostramos los Resultados.
fprintf('Comprobación de la firma:\n\n');
fprintf('Hash del certificado: \t%s\n', hashArchivo);
fprintf('Valor m obtenido: \t\t%s\n', hashEnmascarado);

if( Validar == true)
    fprintf('El certificado es válido\n');
else
    fprintf('El certificado no es válido\n');
end