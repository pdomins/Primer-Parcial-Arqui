/*
    4) El programa ejecutable debe ser de arquitectura de 32 bits.
    5) Crear un archivo .C y otro archivo .ASM con sus respectivas funciones.
    6) El módulo de C debe contener al menos una función más además de main()
    y esta función debe ser utilizada.
    Su programa debe recibir dos números mediante lectura del teclado, realizar
    la suma de ambos e imprimir en la pantalla el resultado.
*/
extern int readFromShell(char* buffer, unsigned int size);
//extern int strlen(char* string);
extern int writeToShell(char * buffer, int size);
//extern char 1* numToStr(int num);

int pot(int base, int exp) {
    if(exp == 0) {
        return 1;
    }
    int resultado = 1;
    while(exp > 0) {
        resultado *= base;
        exp --;
    }
    return resultado;
}

int strToNum(char* input, unsigned int len){
    int rta = 0;
    int idx = 0;
    char aux;
    while( idx != len ){
        rta += (input[idx] - '0') * pot(10, len - idx - 1);
        idx++;
    }
    return rta;
}

int strlen(char * string) {
    int i = 0;
    while(string[i] != 0 && string[i] != '\n') {
        i++;
    }
    return i;
}

int numlen(int num) {
    int i = 0; 
    while(num > 0) {
        i++;
        num /= 10;
    }
    return i;
}

void numToStr(int num, char* string, int len) {
    string[len] = 0;
    for(int i = len - 1; i >= 0; i--) {
        string[i] = (num % 10) + '0';
        num /= 10;
    }
}

int main(int argc, char* argv[]){
    char firstNum[50];
    int size_first = readFromShell(firstNum, 50);
    if(size_first == 0)
        return 0;
    int first = strToNum(firstNum, size_first);
    char secondNum[50];
    int size_second = readFromShell(secondNum, 50);
    if(size_second == 0)
        return 0;
    int second = strToNum(secondNum, size_second);
    int rta = first + second;
    int len = numlen(rta);
    char toPrint[len + 1];
    numToStr(rta, toPrint, len);
    writeToShell("The sum between those numbers is: ",35);
    writeToShell(toPrint, len);
    writeToShell("\n", 1);
    return 0;
}


