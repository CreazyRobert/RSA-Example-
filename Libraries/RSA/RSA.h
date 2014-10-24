//
//  RSA.h
//  RSA Example
//
//  Created by JS Lim on 1/7/14.
//  Copyright (c) 2014 JS Lim. All rights reserved.
//

#ifndef JS_RSA_h
#define JS_RSA_h

char *js_private_decrypt(const char *cipher_text, const char *private_key_path); //私钥加密
char *js_public_encrypt(const char *plain_text, const char *public_key_path);  //公钥解密


char *js_private_encrypt(const char *plain_text, const char *private_key_path); //私钥解密
char *js_public_decrypt(const char *cipher_text, const char *public_key_path); //公钥加密


//签名 参数未知什么意思  （暂不可用）
unsigned char *rsaPKCS1SignData(const unsigned char *src,int src_len,unsigned char *pri_key,int pri_key_len, int *dst_len);


//内存读取私钥解密  (important)
char *js_privatestring_decrypt(const char *cipher_text, char *private_key_string);
//内存读取公钥加密  (important)
char *js_publicstring_encrypt(const char *plain_text, char *public_key_string);

#endif