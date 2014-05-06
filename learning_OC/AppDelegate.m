//
//  AppDelegate.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "AppDelegate.h"
#import "GQTInformationViewController.h"
#import "GQTVideoViewController.h"
#import "GQTBookViewController.h"
#import "GCQMoreViewController.h"

#import "GQTCommons.h"

@implementation AppDelegate
@synthesize tabBarMain;
@synthesize userInfo;

- (void)dealloc
{
    [tabBarMain release];
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    GQTInformationViewController *info_ = [[[GQTInformationViewController alloc] initWithNibName:@"GQTInformationViewController" bundle:nil] autorelease];
    GQTVideoViewController *video_ = [[[GQTVideoViewController alloc] initWithNibName:@"GQTVideoViewController" bundle:nil] autorelease];
    GQTBookViewController *book_ = [[[GQTBookViewController alloc] initWithNibName:@"GQTBookViewController" bundle:nil] autorelease];
    GCQMoreViewController *more_ = [[[GCQMoreViewController alloc] initWithNibName:@"GCQMoreViewController" bundle:nil] autorelease];
    
    UINavigationController *nav_1 = [[[UINavigationController alloc] initWithRootViewController:info_] autorelease];
    nav_1.tabBarItem.image = [UIImage imageNamed:@"ico_recommend_active.png"];
    nav_1.tabBarItem.title = @"最新推荐";
    UINavigationController *nav_2 = [[[UINavigationController alloc] initWithRootViewController:book_] autorelease];
    nav_2.tabBarItem.image = [UIImage imageNamed:@"ico_ebook_active.png"];
    nav_2.tabBarItem.title = @"书籍学习";
    UINavigationController *nav_3 = [[[UINavigationController alloc] initWithRootViewController:video_] autorelease];
    nav_3.tabBarItem.image = [UIImage imageNamed:@"ico_course_active.png"];
    nav_3.tabBarItem.title = @"视频学习";
    UINavigationController *nav_4 = [[[UINavigationController alloc] initWithRootViewController:more_] autorelease];
    nav_4.tabBarItem.image = [UIImage imageNamed:@"ico_more_active.png"];
    nav_4.tabBarItem.title = @"更多";
    
    NSArray *arrViews = [NSArray arrayWithObjects:nav_1,nav_2,nav_3,nav_4, nil];
    
    GQTTabBarController *tabbar_ = [[GQTTabBarController alloc] init];
    tabbar_.viewControllers = arrViews;
    [[tabbar_ tabBar] setBackgroundImage:[GQTCommons getTabBarBackImage]];
    [[tabbar_ tabBar] setSelectedImageTintColor:[UIColor clearColor]];
    [[tabbar_ tabBar] setTintColor:[UIColor blackColor]];
    self.tabBarMain = tabbar_;
    [tabbar_ release];
    
    NSArray *subViews = [self.tabBarMain.view subviews];
    UITabBar *tabBar = [subViews objectAtIndex:1];
    tabBar.layer.contents = (id)[GQTCommons getNavigationBarBackImage].CGImage;
    
    NSData *userdata = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfo];
    
    if (userdata != nil) {
        self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userdata];
    }else{
        self.userInfo = nil;
    }
    
    self.window.rootViewController = self.tabBarMain;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UINavigationController *)selectedNavigationController {
    UIViewController *vc = self.tabBarMain.selectedViewController;
    assert([vc isKindOfClass:[UINavigationController class]]);
    return (UINavigationController *) vc;
}

@end
