//
//  NSData+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/8/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LM)

/**
 *  AES加密
 *
 *  @param key 密钥
 *
 *  @return NSData
 */
- (NSData *)lm_AES256EncryptWithKey:(NSString *)key;

/**
 *  AES解密
 *
 *  @param key 密钥
 *
 *  @return NSData
 */
- (NSData *)lm_AES256DecryptWithKey:(NSString *)key;

@end
