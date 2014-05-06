//
//  NSString+Helper.m
//  vik_learning_ios
//
//  Created by Yang Lijuan on 13-3-12.
//  Copyright (c) 2013年 neu. All rights reserved.
//

#import "NSString+Helper.h"
#import "GTMBase64.h"

@implementation NSString (Helper)
- (NSString *) encodeToBase64{
	NSString *r=[GTMBase64 stringByEncodingData:[NSData dataWithBytes:[self UTF8String] 
															   length:strlen([self UTF8String])]];
	return r;
}

- (NSString *) decodeFromBase64{
	NSString *r;
	if(self!=@""){
		NSData *data=[GTMBase64 decodeData:[NSData dataWithBytes:[self UTF8String] 
														  length:strlen([self UTF8String])]];
		r=[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	}else {
		r=@"";
	}
	return r;
}

- (NSString *)trimWhitespace
{
	NSMutableString *mStr = [self mutableCopy];
	CFStringTrimWhitespace((CFMutableStringRef)mStr);
	
	NSString *result = [mStr copy];
	
	[mStr release];
	return [result autorelease];
}
@end
