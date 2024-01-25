% Limpiamos el workspace y el command window
clear
clc

% Antes de nada, cargamos el archivo que contiene los datos
load('datos.mat')

% Definimos los bits de manera aleatoria para nuestra Clave RSA en un rango de 200 a 256 bits
numeroBits = randi([200, 256]);

% Clave RSA
[n,e,d] = claveRSA1(numeroBits);

% Pasamos los valores a hexadecimal
iden = 'Gonzalo De Los Reyes Sánchez';
mod = dec2hex(n);
exp = dec2hex(e);
priv = dec2hex(d);

% Creamos la firma
unionFirma = strcat(iden,mod,exp);

% Creamos nuestro archivo temporal
fileID = fopen('ficherotemporal.bin','w');
fwrite(fileID,unionFirma);
fclose(fileID);

% Creamos la firma digital de dicho archivo temporal usando la clave privada keyAuto.
[firma, hash] = Firmadigital('ficherotemporal.bin', keyAuto.modulo, keyAuto.privada);
% No eliminaremos el fichero temporal para posteriormente en el hito 3 no
% tener que crear otro, así simplicaremos y utilizar este fichero,
% finalemnte en el hito 3 una vez ya utilizado, ya podremos borrarlo.

% Comprobamos que la clave sea del número de bits mencionado:
if( numeroBits == floor(log2(n))+1)
    fprintf('Comprobación de número de bits correcta.\n');

% Estrucutramos los datos
micertificado = struct('iden',{iden},'mod',{mod},'exp',{exp},'priv',priv,'firma',firma)

% Guardamos el Certificado
save('micertificado.mat','iden','mod','exp','priv','firma')
else
    fprintf('Comprobación de número de bits incorrecta.\n');
end
