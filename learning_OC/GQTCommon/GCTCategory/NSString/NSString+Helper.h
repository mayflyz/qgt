//
//  NSString+Helper.h
//  vik_learning_ios
//
//  Created by Yang Lijuan on 13-3-12.
//  Copyright (c) 2013年 neu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
//return nsstring without any whitespace
- (NSString *)trimWhitespace;
#pragma mark base64
//return the string's base64 value as string
- (NSString *) encodeToBase64;

//decode the string's base64 value as string
- (NSString *) decodeFromBase64;

@end
