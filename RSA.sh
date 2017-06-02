#!/bin/bash

dir=rsa/
private="private.pem"
public="public.pem"
pass="12345"
key_sizes=(1024 2048 4096)
file_sizes=(512b 1024kB 4MB 32MB 64MB 128MB)
block_sizes=(1 1kB 1MB 1MB 1MB 1MB)
block_count=(512 1024 4 32 64 128)

echo "Cleaning ${dir} directory"
rm -rf ${dir}
mkdir -p ${dir}

for i in "${!key_sizes[@]}"; do
    size=${key_sizes[i]};

    echo "Generating private key(${size}) in ${dir}"
	openssl genrsa -des3 -out ${dir}private${size} -passout pass:${pass} ${size} >& /dev/null

	echo "Extracting public key(${size}) in ${dir}"
    openssl rsa -in ${dir}private${size} -outform PEM -pubout -out ${dir}public${size} -passin pass:${pass} >& /dev/null
done

for i in "${!file_sizes[@]}"; do
    size=${file_sizes[i]};

    of=${dir}${size}
    bs=${block_sizes[i]}
    count=${block_count[i]}

    echo "Generating random file(${size}) in ${dir}"
    dd if=/dev/urandom of=${of} bs=${bs} count=${count} >& /dev/null
done

echo "Symmetric encryption"
for i in "${!file_sizes[@]}"; do
    size=${file_sizes[i]};
    in=${dir}${size}
    enc=${in}.des.enc
    dec=${in}.des.dec

    echo "Encrypting file ${in} to ${enc}"
    time openssl enc -des -in ${in} -out ${enc} -pass pass:${pass}

    echo "Decrypting file ${enc} to ${dec}"
    time openssl enc -des -d -in ${enc} -out ${dec} -pass pass:${pass}
done

echo "RSA encryption"
for k in "${!key_sizes[@]}"; do
    key=${key_sizes[k]}

    for i in "${!file_sizes[@]}"; do
        file=${file_sizes[i]}
        in=${dir}${file}
        enc=${dir}${file}.${key}.enc
        dec=${dir}${file}.${key}.dec

        private=${dir}private${key}
        public=${dir}public${key}
        bin=${dir}key.bin
        bin_enc=${bin}.enc
        bin_dec=${bin}.dec

        echo "Encrypting file ${in} to ${enc}"

        openssl rand -base64 32 > ${bin}
        time (
          openssl rsautl -encrypt -inkey ${public} -pubin -in ${bin} -out ${bin_enc} &&
          openssl enc -des -salt -in ${in} -out ${enc} -pass file:${bin}
        )

        echo "Decrypting file ${enc} to ${dec}"
        time (
          openssl rsautl -decrypt -inkey ${private} -in ${bin_enc} -out ${bin_dec} -passin pass:${pass} &&
          openssl enc -d -des -in ${enc} -out ${dec} -pass file:${bin}
        )
    done
done

