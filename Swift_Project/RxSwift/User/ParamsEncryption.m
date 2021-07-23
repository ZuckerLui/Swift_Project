//
//  ParamsEncryption.m
//  Swift_Project
//
//  Created by jimi01 on 2021/4/30.
//  Copyright © 2021 lvzheng. All rights reserved.
//

#import "ParamsEncryption.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation ParamsEncryption
+ (NSDictionary *)encryptionParams:(NSDictionary *)parameters {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [params setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"timestamp"];
    [params setObject:@"449A7D0E9C1911E7BEDB00219B9A2EF3" forKey:@"app_key"];
    [params setObject:[ParamsEncryption signToRequest:params secret:@"695c1a459c1911e7bedb00219b9a2ef3" signMethod:@"md5"] forKey:@"sign"];
    return params;
}

+ (NSString *)signToRequest:(NSDictionary *)params
                     secret:(NSString *)secret
                 signMethod:(NSString *)signMethod
{
    
    //第一步：检查参数是否已经排序
    NSArray *keys = params.allKeys;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        return [obj1 compare:obj2];
    };
    NSArray *keysSort = [keys sortedArrayUsingComparator:sort];
    
    //第二步：把所有参数名和参数串在一起
    NSMutableString *appendStr = [[NSMutableString alloc] init];
    if ([@"md5" isEqualToString:signMethod]) {
        [appendStr appendString:secret];
    }
    
    for (NSString *key in keysSort) {
        NSString *value = params[key];
        if (value && value.length != 0) {
            [appendStr appendString:[NSString stringWithFormat:@"%@%@",key,value]];
        }
    }
    // 第三步：使用MD5加密
    [appendStr appendString:secret];
    NSString *md5Result = [self md5HexDigest:appendStr];
    
    return md5Result;
    
}


//MARK - md5加密
+ (NSString *) md5HexDigest:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

// DES加密
+(NSString *)encryptUseDES:(NSString *)clearText
{
    NSString *key = @"JiMiTrackSolid";
    NSString *ciphertext = nil;
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void * buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String], kCCBlockSizeDES,
                                          NULL,
                                          [textData bytes]  , dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        //DES加密成功
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [self stringWithHexBytes2:data];
        
    }
    
    free(buffer);
    return ciphertext;
}

//nsdata转成16进制字符串
+ (NSString*)stringWithHexBytes2:(NSData *)sender {
    static const char hexdigits[] = "0123456789ABCDEF";
    const size_t numBytes = [sender length];
    const unsigned char* bytes = [sender bytes];
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    
    for (int i = 0; i<numBytes; ++i) {
        const unsigned char c = *bytes++;
        *hex++ = hexdigits[(c >> 4) & 0xF];
        *hex++ = hexdigits[(c ) & 0xF];
    }
    
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    
    free(strbuf);
    return hexBytes;
}
@end
