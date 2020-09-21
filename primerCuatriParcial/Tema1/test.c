#include <stdio.h>

//int pot(int base, int exp){
//    if(exp==0){
//        base = 1;
//    }
//   else if (exp%2 == 0) {
//        return pot(base, exp/2) * pot(base, exp/2);
//   }
//   else
//        return base * pot(base, exp/2) * pot(base, exp/2);
//}

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

int strToNum(const char* input, unsigned int len){
    int rta = 0;
    int idx = 0;
    char aux;
    while( idx != len && input[idx]!= '\n'){
        rta += (input[idx] - '0') * pot(10, len - idx - 1);
        idx++;
    }
    return rta;
}

int stringlen(char * string) {
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

void numToStr(int num, char * string, int len) {
    string[len] = 0;
    for(int i = len - 1; i >= 0; i--) {
        string[i] = (num % 10) + '0';

        num /= 10;
    }
}

int main(int argc, char * argv[]) {
    int num = 2345;
    int len = numlen(num);
    char string[len + 1];
    string[len] = 0;
    printf("Numero: %d - Longitud: %d\n", num, len); //2345 - 4
    numToStr(num, string, len);
    printf("%s\n", string);
    for(int i = 0; i < len; i++) {
        printf("%c", (int)string[i]);
    }putchar('\n');
    int num2 = strToNum(string, len);
    printf("Num2: %d\n", num2);
}