//
//  ParamsEncryption.h
//  Swift_Project
//
//  Created by lz on 2021/4/30.
//  Copyright © 2021 lvzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParamsEncryption : NSObject
+ (NSString *)signToRequest:(NSDictionary *)params
                     secret:(NSString *)secret
                 signMethod:(NSString *)signMethod;

//MARK - md5加密
+ (NSString *) md5HexDigest:(NSString *)str;
+ (NSDictionary *)encryptionParams:(NSDictionary *)parameters;

+(NSString *)encryptUseDES:(NSString *)clearText;
@end

NS_ASSUME_NONNULL_END
