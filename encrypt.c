#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(){

	int choose;
	printf("CBC(0) or ECB(1)\n");
	scanf("%d", &choose);

	printf("%d \n", choose);

	if(choose == 0){
		system("openssl aes-256-cbc -a -salt -in plain_image.raw -out plain_image_cbc.raw.enc");
	}else{
		system("openssl aes-256-ecb -a -salt -in plain_image.raw -out plain_image_ecb.raw.enc");
	}
	return 0;
}