#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(){

	printf("Encrypt cbc:\n");
		system("openssl aes-256-cbc -a -salt -in plain_image_cbc.raw.enc -out plain_image_cbc.raw.dec");

	printf("Encrypt ecb:\n");
		system("openssl aes-256-ecb -a -salt -in plain_image_ecb.raw.enc -out plain_image_ecb.raw.dec");
	return 0;
}