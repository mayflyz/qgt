//
//  GQTCommons.h
//  learning_OC
//
//  Created by test on 3/21/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserInfo @"userInfo"

@interface GQTCommons : NSObject

+ (NSString *)getImageUrl:(NSString *)imagetail;

+ (UIImage *)getNavigationBarBackImage;

+ (void)setViewBackImage:(UIView *)view;

+ (UIImage *)getTabBarBackImage;

+ (void)setViewCornerRadius:(UIView*)view;
@end
