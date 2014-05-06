//
//  GQTUserInfoViewController.m
//  learning_OC
//
//  Created by test on 4/12/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTUserInfoViewController.h"

#import "AppDelegate.h"
#import "GQTUserInfo.h"
#import "GQTCommons.h"

@interface GQTUserInfoViewController (){
    GQTUserInfo *userInfo;
}

@property (retain, nonatomic) GQTUserInfo *userInfo;
@end

@implementation GQTUserInfoViewController
@synthesize userInfo;

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
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView_content setContentSize:CGSizeMake(320, 460 + (iPhone5 ? 88 : 0))] ;
    self.userInfo = APP_DELEGATE.userInfo;
    
    [GQTCommons setViewBackImage:self.view];
    [GQTCommons setViewCornerRadius:self.backImageView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [rightBtn setBackgroundImage:[GQTCommons getNavigationBarBackImage] forState:UIControlStateNormal];
    [rightBtn setTitle:@"注销" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
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


- (void)initNavigationBar{
    self.navigationItem.title = @"个人中心";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    
    self.label_userName.text = [NSString stringWithFormat:@"用户名: %@",self.userInfo.userLogin];
    self.label_nikeName.text = [NSString stringWithFormat:@"昵  称: %@",self.userInfo.userNike];
    self.label_email.text = [NSString stringWithFormat:@"邮  箱: %@",self.userInfo.userLogin];
    self.label_phone.text = [NSString stringWithFormat:@"手  机: %@",self.userInfo.userPhone];
    self.label_area.text = [NSString stringWithFormat:@"所属区域: %@",self.userInfo.userArea];
}

- (IBAction)loginOut:(id)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"是否退出登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:UserInfo];
        APP_DELEGATE.userInfo = nil;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_backImageView release];
    [_label_userName release];
    [_label_nikeName release];
    [_label_email release];
    [_label_phone release];
    [_label_area release];
    [_scrollView_content release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBackImageView:nil];
    [self setLabel_userName:nil];
    [self setLabel_nikeName:nil];
    [self setLabel_email:nil];
    [self setLabel_phone:nil];
    [self setLabel_area:nil];
    [self setScrollView_content:nil];
    [super viewDidUnload];
}
@end
