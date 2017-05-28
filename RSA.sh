#!/bin/bash

lenght_key=2048
private_key="private.pem"
public_key="public.pem"
pass="12345"

#openssl genpkey -algorithm RSA -out private privtekey.pem - pkeyopt rsa keygen bits:$lenght_key 
#RSA2048
 openssl genrsa -des3 -out private_key2048 2048 #-passout file:pass.txt
 openssl rsa -in private_key2048 -outform PEM -pubout -out public_key2048 #-passin file:pass.txt

#RSA1024
 openssl genrsa -des3 -out private_key1024 1024 #-passout file:pass.txt
 openssl rsa -in private_key1024 -outform PEM -pubout -out public_key1024 #-passin file:pass.txt

#RSA4096
 openssl genrsa -des3 -out private_key4096 4096 #-passout file:pass.txt
 openssl rsa -in private_key4096 -outform PEM -pubout -out public_key4096 #-passin file:pass.txt

echo "PRIVATE"
cat $private_key
echo "PUBLIC"
cat $public_key

dd if=/dev/urandom of=512b bs=1 count=512
dd if=/dev/urandom of=1024kb bs=1KB count=512
dd if=/dev/urandom of=512kb bs=1KB count=512
dd if=/dev/urandom of=4mb bs=1MB count=4
dd if=/dev/urandom of=32mb bs=1MB count=32
dd if=/dev/urandom of=64mb bs=1MB count=64
dd if=/dev/urandom of=128mb bs=1MB count=128


echo "SYMMETRIC ENC"
time openssl enc -des -in 512b -out 512b.des.enc -pass pass:$pass
time openssl enc -des -in 1024kb -out 1024kb.des.enc -pass pass:$pass
time openssl enc -des -in 4mb -out 4mb.des.enc -pass pass:$pass
time openssl enc -des -in 32mb -out 32mb.des.enc -pass pass:$pass
time openssl enc -des -in 64mb -out 64mb.des.enc -pass pass:$pass
time openssl enc -des -in 128mb -out 128mb.des.enc -pass pass:$pass


echo "SYMMETRIC DEC"
time openssl enc -des -d -in 512b.des.enc -out 512b.des.dec -pass pass:$pass
time openssl enc -des -d -in 1024kb.des.enc -out 1024kb.des.dec -pass pass:$pass
time openssl enc -des -d -in 4mb.des.enc -out 4mb.des.dec -pass pass:$pass
time openssl enc -des -d -in 32mb.des.enc -out 32mb.des.dec -pass pass:$pass
time openssl enc -des -d -in 64mb.des.enc -out 64mb.des.dec -pass pass:$pass
time openssl enc -des -d -in 128mb.des.enc -out 128mb.des.dec -pass pass:$pass
	



echo "RSA1024 ENC"
time openssl smime -encrypt -binary -des  -in 512b -out 512b.rsa1024.enc -outform DER public_key1024 
time openssl smime -encrypt -binary -des -in 512kb -out 512kb.rsa1024.enc -outform DER public_key1024 
time openssl smime -encrypt -binary -des -in 4mb -out 4mb.rsa1024.enc -outform DER public_key1024 
time openssl smime -encrypt -binary -des -in 32mb -out 32mb.rsa1024.enc -outform DER public_key1024 
time openssl smime -encrypt -binary -des -in 64mb -out 64mb.rsa1024.enc -outform DER public_key1024 
time openssl smime -encrypt -binary -des -in 128mb -out 128mb.rsa1024.enc -outform DER public_key1024 



echo "RSA1024 DEC"
time openssl rsautl -decrypt -inkey private_key1024  -in 512b.rsa1024.enc -out 512b.rsa1024.dec	
time openssl rsautl -decrypt -inkey private_key1024  -in 512kb.rsa1024.enc -out 512kb.rsa1024.dec	
time openssl rsautl -decrypt -inkey private_key1024  -in 4mb.rsa1024.enc -out 4mb.rsa1024.dec	
time openssl rsautl -decrypt -inkey private_key1024  -in 32mb.rsa1024.enc -out 32mb.rsa1024.dec	
time openssl rsautl -decrypt -inkey private_key1024  -in 64mb.rsa1024.enc -out 64mb.rsa1024.dec	
time openssl rsautl -decrypt -inkey private_key1024  -in 128mb.rsa1024.enc -out 128mb.rsa1024.dec	

exit
echo "RSA2048 ENC"
time openssl rsautl -encrypt -inkey public_key2048 -pubin -in 512b -out 512b.rsa2048.enc
time openssl rsautl -encrypt -inkey public_key2048 -pubin -in 512kb -out 512kb.rsa2048.enc
time openssl rsautl -encrypt -inkey public_key2048 -pubin -in 4mb -out 4mb.rsa2048.enc
time openssl rsautl -encrypt -inkey public_key2048 -pubin -in 32mb -out 32mb.rsa2048.enc
time openssl rsautl -encrypt -inkey public_key2048 -pubin -in 64mb -out 64mb.rsa2048.enc
time openssl rsautl -encrypt -inkey public_key2048 -pubin -in 128mb -out 128mb.rsa2048.enc


echo "RSA2048 DEC"
time openssl rsautl -decrypt -inkey private_key2048 -pubin -in 512b.rsa2048.enc -out 512b.rsa2048.dec	
time openssl rsautl -decrypt -inkey private_key2048 -pubin -in 512kb.rsa2048.enc -out 512kb.rsa2048.dec	
time openssl rsautl -decrypt -inkey private_key2048 -pubin -in 4mb.rsa2048.enc -out 4mb.rsa2048.dec	
time openssl rsautl -decrypt -inkey private_key2048 -pubin -in 32mb.rsa2048.enc -out 32mb.rsa2048.dec	
time openssl rsautl -decrypt -inkey private_key2048 -pubin -in 64mb.rsa2048.enc -out 64mb.rsa2048.dec	
time openssl rsautl -decrypt -inkey private_key2048 -pubin -in 128mb.rsa2048.enc -out 128mb.rsa2048.dec	

echo "RSA4096 ENC"
time openssl rsautl -encrypt -inkey public_key4096 -pubin -in 512b -out 512b.rsa4096.enc
time openssl rsautl -encrypt -inkey public_key4096 -pubin -in 512kb -out 512kb.rsa4096.enc
time openssl rsautl -encrypt -inkey public_key4096 -pubin -in 4mb -out 4mb.rsa4096.enc
time openssl rsautl -encrypt -inkey public_key4096 -pubin -in 32mb -out 32mb.rsa4096.enc
time openssl rsautl -encrypt -inkey public_key4096 -pubin -in 64mb -out 64mb.rsa4096.enc
time openssl rsautl -encrypt -inkey public_key4096 -pubin -in 128mb -out 128mb.rsa4096.enc


echo "RSA4096 DEC"
time openssl rsautl -decrypt -inkey private_key4096 -pubin -in 512b.rsa4096.enc -out 512b.rsa4096.dec	
time openssl rsautl -decrypt -inkey private_key4096 -pubin -in 512kb.rsa4096.enc -out 512kb.rsa4096.dec	
time openssl rsautl -decrypt -inkey private_key4096 -pubin -in 4mb.rsa4096.enc -out 4mb.rsa4096.dec	
time openssl rsautl -decrypt -inkey private_key4096 -pubin -in 32mb.rsa4096.enc -out 32mb.rsa4096.dec	
time openssl rsautl -decrypt -inkey private_key4096 -pubin -in 64mb.rsa4096.enc -out 64mb.rsa4096.dec	
time openssl rsautl -decrypt -inkey private_key4096 -pubin -in 128mb.rsa4096.enc -out 128mb.rsa4096.dec	

