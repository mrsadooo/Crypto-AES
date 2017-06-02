#!/bin/bash

dir=rsa
lenght_key=2048
private_key="private.pem"
public_key="public.pem"
pass="12345"

#RSA2048
openssl genrsa -des3 -out ${dir}/private_key2048 2048 #-passout file:pass.txt
openssl rsa -in private_key2048 -outform PEM -pubout -out ${dir}/public_key2048

#RSA1024
openssl genrsa -des3 -out ${dir}/private_key1024 1024 #-passout file:pass.txt
openssl rsa -in private_key1024 -outform PEM -pubout -out ${dir}/public_key1024

#RSA4096
openssl genrsa -des3 -out ${dir}/private_key4096 4096 #-passout file:pass.txt
openssl rsa -in private_key4096 -outform PEM -pubout -out ${dir}/public_key4096

dd if=/dev/urandom of=${dir}/512b bs=1 count=512
dd if=/dev/urandom of=${dir}/1024kb bs=1KB count=512
dd if=/dev/urandom of=${dir}/512kb bs=1KB count=512
dd if=/dev/urandom of=${dir}/4mb bs=1MB count=4
dd if=/dev/urandom of=${dir}/32mb bs=1MB count=32
dd if=/dev/urandom of=${dir}/64mb bs=1MB count=64
dd if=/dev/urandom of=${dir}/128mb bs=1MB count=128


echo "SYMMETRIC ENC"
time openssl enc -des -in ${dir}/512b -out ${dir}/512b.des.enc -pass pass:${pass}
time openssl enc -des -in ${dir}/1024kb -out ${dir}/1024kb.des.enc -pass pass:${pass}
time openssl enc -des -in ${dir}/4mb -out ${dir}/4mb.des.enc -pass pass:${pass}
time openssl enc -des -in ${dir}/32mb -out ${dir}/32mb.des.enc -pass pass:${pass}
time openssl enc -des -in ${dir}/64mb -out ${dir}/64mb.des.enc -pass pass:${pass}
time openssl enc -des -in ${dir}/128mb -out ${dir}/128mb.des.enc -pass pass:${pass}

echo "SYMMETRIC DEC"
time openssl enc -des -d -in ${dir}/512b.des.enc -out ${dir}/512b.des.dec -pass pass:${pass}
time openssl enc -des -d -in ${dir}/1024kb.des.enc -out ${dir}/1024kb.des.dec -pass pass:${pass}
time openssl enc -des -d -in ${dir}/4mb.des.enc -out ${dir}/4mb.des.dec -pass pass:${pass}
time openssl enc -des -d -in ${dir}/32mb.des.enc -out ${dir}/32mb.des.dec -pass pass:${pass}
time openssl enc -des -d -in ${dir}/64mb.des.enc -out ${dir}/64mb.des.dec -pass pass:${pass}
time openssl enc -des -d -in ${dir}/128mb.des.enc -out ${dir}/128mb.des.dec -pass pass:${pass}

echo "RSA1024 ENC"
time openssl smime -encrypt -binary -des -in ${dir}/512b -out ${dir}/512b.rsa1024.enc -outform DER ${dir}/public_key1024
time openssl smime -encrypt -binary -des -in ${dir}/512kb -out ${dir}/512kb.rsa1024.enc -outform DER ${dir}/public_key1024
time openssl smime -encrypt -binary -des -in ${dir}/4mb -out ${dir}/4mb.rsa1024.enc -outform DER ${dir}/public_key1024
time openssl smime -encrypt -binary -des -in ${dir}/32mb -out ${dir}/32mb.rsa1024.enc -outform DER ${dir}/public_key1024
time openssl smime -encrypt -binary -des -in ${dir}/64mb -out ${dir}/64mb.rsa1024.enc -outform DER ${dir}/public_key1024
time openssl smime -encrypt -binary -des -in ${dir}/128mb -out ${dir}/128mb.rsa1024.enc -outform DER ${dir}/public_key1024

echo "RSA1024 DEC"
time openssl rsautl -decrypt -inkey ${dir}/private_key1024 -in ${dir}/512b.rsa1024.enc -out ${dir}/512b.rsa1024.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key1024 -in ${dir}/512kb.rsa1024.enc -out ${dir}/512kb.rsa1024.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key1024 -in ${dir}/4mb.rsa1024.enc -out ${dir}/4mb.rsa1024.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key1024 -in ${dir}/32mb.rsa1024.enc -out ${dir}/32mb.rsa1024.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key1024 -in ${dir}/64mb.rsa1024.enc -out ${dir}/64mb.rsa1024.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key1024 -in ${dir}/128mb.rsa1024.enc -out ${dir}/128mb.rsa1024.dec

echo "RSA2048 ENC"
time openssl rsautl -encrypt -inkey ${dir}/public_key2048 -pubin -in ${dir}/512b -out ${dir}/512b.rsa2048.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key2048 -pubin -in ${dir}/512kb -out ${dir}/512kb.rsa2048.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key2048 -pubin -in ${dir}/4mb -out ${dir}/4mb.rsa2048.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key2048 -pubin -in ${dir}/32mb -out ${dir}/32mb.rsa2048.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key2048 -pubin -in ${dir}/64mb -out ${dir}/64mb.rsa2048.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key2048 -pubin -in ${dir}/128mb -out ${dir}/128mb.rsa2048.enc


echo "RSA2048 DEC"
time openssl rsautl -decrypt -inkey ${dir}/private_key2048 -pubin -in ${dir}/512b.rsa2048.enc -out ${dir}/512b.rsa2048.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key2048 -pubin -in ${dir}/512kb.rsa2048.enc -out ${dir}/512kb.rsa2048.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key2048 -pubin -in ${dir}/4mb.rsa2048.enc -out ${dir}/4mb.rsa2048.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key2048 -pubin -in ${dir}/32mb.rsa2048.enc -out ${dir}/32mb.rsa2048.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key2048 -pubin -in ${dir}/64mb.rsa2048.enc -out ${dir}/64mb.rsa2048.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key2048 -pubin -in ${dir}/128mb.rsa2048.enc -out ${dir}/128mb.rsa2048.dec

echo "RSA4096 ENC"
time openssl rsautl -encrypt -inkey ${dir}/public_key4096 -pubin -in ${dir}/512b -out ${dir}/512b.rsa4096.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key4096 -pubin -in ${dir}/512kb -out ${dir}/512kb.rsa4096.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key4096 -pubin -in ${dir}/4mb -out ${dir}/4mb.rsa4096.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key4096 -pubin -in ${dir}/32mb -out ${dir}/32mb.rsa4096.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key4096 -pubin -in ${dir}/64mb -out ${dir}/64mb.rsa4096.enc
time openssl rsautl -encrypt -inkey ${dir}/public_key4096 -pubin -in ${dir}/128mb -out ${dir}/128mb.rsa4096.enc


echo "RSA4096 DEC"
time openssl rsautl -decrypt -inkey ${dir}/private_key4096 -pubin -in ${dir}/512b.rsa4096.enc -out ${dir}/512b.rsa4096.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key4096 -pubin -in ${dir}/512kb.rsa4096.enc -out ${dir}/512kb.rsa4096.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key4096 -pubin -in ${dir}/4mb.rsa4096.enc -out ${dir}/4mb.rsa4096.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key4096 -pubin -in ${dir}/32mb.rsa4096.enc -out ${dir}/32mb.rsa4096.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key4096 -pubin -in ${dir}/64mb.rsa4096.enc -out ${dir}/64mb.rsa4096.dec
time openssl rsautl -decrypt -inkey ${dir}/private_key4096 -pubin -in ${dir}/128mb.rsa4096.enc -out ${dir}/128mb.rsa4096.dec

