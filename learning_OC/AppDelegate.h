//
//  AppDelegate.h
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQTTabBarController.h"
#import "GQTUserInfo.h"

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
      GQTUserInfo *userInfo;
}


@property (retain, nonatomic) GQTUserInfo *userInfo;
@property (strong, nonatomic) UIWindow              *window;
@property (nonatomic, retain) GQTTabBarController    *tabBarMain;


- (UINavigationController *)selectedNavigationController;
@end
