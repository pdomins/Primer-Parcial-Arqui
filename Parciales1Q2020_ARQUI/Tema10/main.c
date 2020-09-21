extern int f_read(unsigned int file_descriptor, char * buffer, unsigned int size);
extern int f_close(int file_descriptor);
extern int f_open(const char * file_name, int access_mode, unsigned short file_permissions);
extern int f_write(unsigned int file_descriptor, char * buffer, unsigned int size);
extern int f_create_file(const char *file_name, unsigned int mode);

void fillString(char* stringA, int lenA, char* stringB, int lenB, char* output){
    for(int i = 0 ; i < lenA; i++ ){
        output[i] = stringA[i];
    }
    for(int i = 0 ; i < lenB ; i++ ){
        output[lenA + i] = stringB[i];
    }
}

int main(int argc, char* argv[]){
    int fd_A = f_open("archivoA.txt", 0, 0); //0 : Read only //:File permissions
    int fd_B = f_open("archivoB.txt", 0, 0);
    int fd_C = f_create_file("archivoC.txt", 0777 );
    char stringA[10];
    char stringB[10];
    int lenA = f_read(fd_A, stringA, 10);
    int lenB = f_read(fd_B, stringB, 10);
    char stringC[lenA + lenB];
    fillString(stringA, lenA, stringB, lenB, stringC);
    f_write(fd_C, stringC,lenA + lenB);
    f_close(fd_A);
    f_close(fd_B);
    f_close(fd_C);
    return 0;
}