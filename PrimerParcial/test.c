#include <stdio.h>

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

void numToStr(int num, char* string, int len) {
    string[len] = 0;
    for(int i = len - 1; i >= 0; i--) {
        string[i] = (num % 10) + '0';
        num /= 10;
    }
}

int numlen(int num) {
    int i = 0; 
    while(num > 0) {
        i++;
        num /= 10;
    }
    return i;
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

void order(int* vec, int len){
    for(int i = 0; i < len - 1; i++) {
        for(int j = i + 1; j < len; j++) {
            if(vec[i] > vec[j]) {
                int aux = vec[i];
                vec[i] = vec[j];
                vec[j] = aux;
            }
        }
    }
}

/*Only test unit*/
void printVec(int* vec, int len) {
    for(int i = 0; i < len; i++) {
        printf("%d  ", vec[i]);
    }putchar('\n');
}

int main(int argc, char * argv[]) {
    int vec[] = {12, 32, 45, 32, 21, 45, 76, 23, 45,99,43,23,56,4566,23,432,123,5345,0};
    int len = sizeof(vec)/sizeof(int);
    printVec(vec, len);
    order(vec, len);
    printVec(vec, len);

    int n = 123456;
    char
}
