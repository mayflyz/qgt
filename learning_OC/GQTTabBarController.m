//
//  GQTTabBarController.m
//  learning_OC
//
//  Created by test on 4/1/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTTabBarController.h"
#import "GQTCommons.h"

@interface GQTTabBarController (){
    UIView * bgView4TabBar_;
}

@property(nonatomic, retain) UIView * bgView4TabBar;
@end

@implementation GQTTabBarController

@synthesize bgView4TabBar = bgView4TabBar_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self customTabBarBackgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [bgView4TabBar_ release];
    [super dealloc];
}

#pragma mark - Custom TabBar Background Color

- (void)customTabBarBackgroundColor
{
    ///给tabbar换背景色
    //
    //frame
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect frame = self.tabBar.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft
                        || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    ? /*横屏*/ appFrame.size.height + 20
    : appFrame.size.width + 20;
    
    //bg color.
#define useTintColor 1
#if useTintColor
    self.bgView4TabBar = [[[UINavigationBar alloc] initWithFrame:frame] autorelease];
    ((UINavigationBar *)self.bgView4TabBar).tintColor = [UIColor colorWithRed:52.0/255.0 green:140.0/255.0 blue:226.0/255.0 alpha:1];
#else
    self.bgView4TabBar = [[[UIView alloc] initWithFrame:frame] autorelease];
    self.bgView4TabBar.backgroundColor = [UIColor colorWithRed:52.0/255.0 green:140.0/255.0 blue:226.0/255.0 alpha:1];
#endif
    //add to.
    [self.tabBar insertSubview:self.bgView4TabBar atIndex:
     self.tabBar.subviews.count - (self.viewControllers.count > 5 ? 5 : self.viewControllers.count)
     ];
}


////为了支持iOS6
-(BOOL)shouldAutorotate
{
    return YES;
}

//为了支持iOS6
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
