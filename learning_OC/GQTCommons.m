//
//  GQTCommons.m
//  learning_OC
//
//  Created by test on 3/21/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTCommons.h"

#import <QuartzCore/QuartzCore.h>

@implementation GQTCommons

+ (NSString *)getImageUrl:(NSString *)imagetail{
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",CR_URL_BASEURL,imagetail];
    
    return stringURL;
}

+ (UIImage *)getNavigationBarBackImage{
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 44));
    UIImage *image = [[UIImage imageNamed:@"iso_topbarbg.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    [image drawInRect:CGRectMake(0, 0, 320, 44)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (UIImage *)getTabBarBackImage{
    UIGraphicsBeginImageContext(CGSizeMake(320, 49));
    UIImage *image = [[UIImage imageNamed:@"iso_topbarbg.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    [image drawInRect:CGRectMake(0, 0, 320, 49)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

+ (void)setViewBackImage:(UIView *)view{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [imageView setImage:[[UIImage imageNamed:@"iso_globalbg.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    [view addSubview:imageView];
    [view sendSubviewToBack:imageView];
    [imageView release];
}

+ (void)setViewCornerRadius:(UIView*)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10.0;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:191.0f/255.0f green:178.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor;
}

@end

