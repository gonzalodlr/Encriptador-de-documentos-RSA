function g = randimpar()
%   RANDIMPAR genera un número simbólico aleatorio impar de 64 bits.

rng('shuffle');
V = randi([0, 4294967295], 'uint32'); % Nota: 4294967295 = 2^32 - 1 (máximo entero de 32 bits)
g = sym(bitor(V, 1)); % Asegura que el número es impar al forzar el último bit a 1
V = randi([0, 4294967295], 'uint32');
g = g + V*sym(4294967296); % Nota: 4294967296 = 2^32

end