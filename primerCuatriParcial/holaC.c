/*
    4) El programa ejecutable debe ser de arquitectura de 32 bits.
    5) Crear un archivo .C y otro archivo .ASM con sus respectivas funciones.
    6) El módulo de C debe contener al menos una función más además de main()
    y esta función debe ser utilizada.
    Su programa debe recibir dos números mediante lectura del teclado, realizar
    la suma de ambos e imprimir en la pantalla el resultado.
*/
extern void readFromShell(char* buffer, unsigned int size);
//extern int strlen(char* string);
extern int writeToShell(char * buffer, int size);
//extern char 1* numToStr(int num);

int pot(int base, int exp){
    if(exp==0){
        base = 1;
    }
   else if (exp%2 == 0) {
        return pot(base, exp/2) * pot(base, exp/2);
   }
   else 
        return base * pot(base, exp/2) * pot(base, exp/2);
}

int strToNum(const char* input, unsigned int len){
    int rta = 0;
    int idx = 0;
    char aux;
    while( idx != len){
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
}

void numToStr(int num, char* string, int len) {
    string[len] = 0;
    for(int i = len - 1; i >= 0; i--) {
        string[i] = num % 10;
        num /= 10;
    }
}

int main(int argc, char* argv[]){
    char firstNum[1];
    readFromShell(firstNum, 2);
    char secondNum[1];
    readFromShell(secondNum, 2);
    writeToShell(firstNum, 1);
    writeToShell(secondNum, 1);
    int first = strToNum(firstNum, strlen(firstNum));
    int second = strToNum(secondNum, strlen(secondNum));
    int rta = first + second;
    int len = numlen(rta);
    char toPrint[len + 1];
    numToStr(rta, toPrint, len);
    //char toPrint = numToStr(rta);
    writeToShell(toPrint, strlen(toPrint));
    return 0;
}


