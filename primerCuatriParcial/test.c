#include <stdio.h>

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
    while( idx != len && input[idx]!= '\n'){
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

int main(int argc, char * argv[]) {
    int num = 2345;
    int len = numlen(num);
    char string[len];
    printf("Numero: %d - Longitud: %d", num, len);
}