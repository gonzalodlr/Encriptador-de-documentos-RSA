% Limpiamos el workspace y el command window
clear
clc

% Cargamos el archivo que contiene los datos
load('datos.mat')

% Leemos la estructura deRaU y estrucutramos los datos:
deRaU = struct('iden',{deRaU.iden},'mod',{deRaU.mod},'exp',{deRaU.exp},'firma',deRaU.firma,'int_u',deRaU.int_u,'int_r',deRaU.int_r,'f_mensaje',deRaU.f_mensaje)

% Primero crearemos un fichero temporal con la cadena 'iden','mod' y 'exp':
cadenaCertificado = strcat(deRaU.iden,deRaU.mod,deRaU.exp);
fileID = fopen('ficherotemporal.bin','w');
fwrite(fileID,cadenaCertificado);
fclose(fileID);

% Verificamos la firma del certificado con el módulo y exponente de keyAuto:
[ValidarCertificado, hashEnmascaradoCertificado, hashArchivoCertificado] = VerificaFirma('ficherotemporal.bin', deRaU.firma, keyAuto.modulo, keyAuto.exponente);

fprintf('Autentificando la identidad de: %s\n\n', deRaU.iden);
fprintf('Hash del certificado: \t%s\n', hashArchivoCertificado);
fprintf('Valor m obtenido: \t\t%s\n', hashEnmascaradoCertificado);

if( ValidarCertificado == true)
    fprintf('El certificado es válido\n\n');
else
    fprintf('El certificado no es válido\n\n');
end

% Eliminaremos y volveremos a crear otro fichero temporal con los datos:
%   - 'iden', 'int_u' y 'int_r'
delete 'ficherotemporal.bin'
cadenaIdentidad = strcat(deRaU.iden,deRaU.int_u,deRaU.int_r);
fileID = fopen('ficherotemporal.bin','w');
fwrite(fileID,cadenaIdentidad);
fclose(fileID);

% Como nuestra función de firma recibe un módulo y un exponente en formato
% decimal, y tenemos el módulo deRaU y el exponente en formato hexdecimal,
% lo pasamos a string con la función strcat y a simbolico con la función
% sym:
modulo = sym(strcat('0x',deRaU.mod));
exponente = sym(strcat('0x',deRaU.exp));

% Verificamos la identidad:
[ValidarIden, hashEnmascaradoIden, hashArchivoIden] = VerificaFirma('ficherotemporal.bin', deRaU.f_mensaje, modulo, exponente);

fprintf('Hash del mensaje: %s\n', hashArchivoIden);
fprintf('Valor m obtenido: %s\n', hashEnmascaradoIden);

if( ValidarIden == true)
    fprintf('La identidad es válida\n');
else
    fprintf('La identidad no es válida\n');
end

% Eliminamos el fichero temporal:
delete 'ficherotemporal.bin'

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Apartado B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cargamos el certificado de nuestro usuario generado en el Hito3
load('micertificado.mat')

% Unimos los strings para verificar la firma de nuestro certificado posteriormente:
firmar = strcat(iden, mod, exp);

fileID = fopen('ficherotemporal.bin','w');
fwrite(fileID,firmar);
fclose(fileID);

% Creamos un fichero temporal con nuestra identidad y los datos deRaU:
%   - 'iden', 'int_u' y 'int_r' -> para realizar la firma de identidad
cadenaIdentidad2 = strcat(iden,deRaU.int_u,deRaU.int_r);
fileID = fopen('ficherotemporal2.bin','w');
fwrite(fileID,cadenaIdentidad2);
fclose(fileID);

% Creamos la firma de nuestro certificado
%[firma, hash] = Firmadigital('ficherotemporal.bin', keyAuto.modulo, keyAuto.privada);

% Creamos la firma del mensaje de identidad
[firma_mensaje, hash2] = Firmadigital('ficherotemporal2.bin', sym(strcat('0x',mod)), sym(strcat('0x',priv)));

% Leemos la estructura deUaR y estrucutramos los datos:
deUaR = struct('iden',{iden},'mod',{mod},'exp',{exp},'firma',firma,'int_u',deRaU.int_u,'int_r',deRaU.int_r,'f_mensaje',firma_mensaje)

% Verificamos el certificado con el módulo y exponente de keyAuto:
[ValidarCertificado, hashEnmascaradoCertificado, hashArchivoCertificado] = VerificaFirma('ficherotemporal.bin', firma, keyAuto.modulo, keyAuto.exponente);

fprintf('Autentificando la identidad de: %s\n\n', iden);
fprintf('Hash del certificado: \t%s\n', hashArchivoCertificado);
fprintf('Valor m obtenido: \t\t%s\n', hashEnmascaradoCertificado);

if( ValidarCertificado == true)
    fprintf('El certificado es válido\n\n');
else
    fprintf('El certificado no es válido\n\n');
end

% Verificamos la identidad:
[ValidarIden2, hashEnmascaradoIden2, hashArchivoIden2] = VerificaFirma('ficherotemporal2.bin', firma_mensaje, sym(strcat('0x',mod)), sym(strcat('0x',exp)));

fprintf('Hash del mensaje: %s\n', hashArchivoIden2);
fprintf('Valor m obtenido: %s\n', hashEnmascaradoIden2);

if( ValidarIden2 == true)
    fprintf('La identidad es válida\n');
else
    fprintf('La identidad no es válida\n');
end

% Eliminamos los ficheros temporales:
delete 'ficherotemporal.bin'
delete 'ficherotemporal2.bin'
