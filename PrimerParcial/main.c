#define SIZE 10
#define BUFFER_SIZE 10

extern int f_read(char *buffer, unsigned int size);
extern int f_write(char * buffer, int size);
extern void exit(int error_code);

/**
  * pot - calcula la potencia de base elevado a exp
  * Sólo válido para exponentes positivos
**/
int pot(int base, unsigned int exp) {
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

/**
  * numToStr - dado un número y su cantidad de dígitos, guarda en un
  * string su representación en chars
**/
void numToStr(int num, char* string, int len) {
    for(int i = len - 1; i >= 0; i--) {
        string[i] = (num % 10) + '0';
        num /= 10;
    }
}

/**
  * numlem - retorna la cantidad de cifras que tiene num
**/
int numlen(unsigned int num) {
    int i = 0; 
    if(num == 0) {
        return 1;
    }
    while(num > 0) {
        i++;
        num /= 10;
    }
    return i;
}

/**
  * strToNum - dada la representación en chars de un número y su longitud,
  * devuelve el número correspondiente
**/
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

/**
  * order - ordena de menor a mayor el arreglo vec
**/
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

int main(int argc, char * argv[]) {
    int array[SIZE];
    char buffer[BUFFER_SIZE];
    int i = 0;
    while(i < SIZE){
        int len = f_read(buffer, BUFFER_SIZE);
        if(len == 0){
            f_write("You should only insert numbers\n",31);
            exit(1);
        }
        array[i++] = strToNum(buffer, len);
    
    }
    order(array, SIZE);
    for(int i = 0; i < SIZE ; i++){
        int amount = numlen(array[i]);
        char toPrint[amount+1];
        toPrint[amount] = ' '; 
        numToStr(array[i], toPrint, amount);
        f_write(toPrint, amount + 1);
    }
    f_write("\n", 1);
    return 0;
}