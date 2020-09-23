extern int readFromShell(char * buffer, int size);
extern int writeToShell(char * buffer, int size);
extern void clear_buffer();


void reverse(char* input, char* reversed, int len){
    for(int i = len; i > 0; i--){
        reversed[i - 1] = input[len - i];
    }
}

int main(int argc, char* argv[]){
    char string[15];
    int len = readFromShell(string, 15);
    if(len < 0)
        return 1;
    char toPrint[len];
    reverse(string, toPrint, len);
    writeToShell(toPrint, len);
    writeToShell("\n", 1);
    clear_buffer();
    return 0;
}