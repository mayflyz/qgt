//
//  GQTLoginViewController.m
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTLoginViewController.h"

#import "MBProgressHUD.h"
#import "NSObject+SBJson.h"
#import "GQTRegisterViewController.h"

#import "GQTUserInfo.h"
#import "UITools.h"
#import "GQTCommons.h"
#import "AppDelegate.h"

@interface GQTLoginViewController ()

- (void)initNavigationBar;

@end

@implementation GQTLoginViewController

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
    [GQTCommons setViewCornerRadius:self.view_loginContent];
    
    [self.scroll_content setContentSize:CGSizeMake(320, (iPhone5 ? 504 : 416))];
    [self initNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_iconImageView release];
    [_loginBtn release];
    [_getNewAccount release];
    [_loginNameImageView release];
    [_passwordImageView release];
    [_loginName release];
    [_password release];
    [_view_loginContent release];
    [_scroll_content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setIconImageView:nil];
    [self setLoginBtn:nil];
    [self setGetNewAccount:nil];
    [self setLoginNameImageView:nil];
    [self setPasswordImageView:nil];
    [self setLoginName:nil];
    [self setPassword:nil];
    [self setView_loginContent:nil];
    [self setScroll_content:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    //添加聊天页面的手势处理
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    
    [super viewWillAppear:animated];
}

- (void)initNavigationBar{
    self.navigationItem.title = @"登录";
//    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}

#pragma mark - keyboard dismiss
- (void)dismissKeyBoard{
    [self.view endEditing:YES];
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

#pragma mark - btn click
- (IBAction)loginBtnClick:(id)sender {
    if (self.loginName.text.length == 0) {
        return;
    }
    
    if (self.password.text.length == 0) {
        return ;
    }
    
    //网络请求
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud showWhileExecuting:@selector(requestFromServer) onTarget:self withObject:nil animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    
    [hud release];
}

- (void)requestFromServer{
    NSString *urlStr = [NSString stringWithFormat:@"%@?loginname=%@&password=%@",CR_URL_LOGIN,self.loginName.text,self.password.text];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.delegate = self;
    request.timeOutSeconds = 20;
    [request startAsynchronous];
}

- (IBAction)getNewAccountClick:(id)sender {
    GQTRegisterViewController *viewController = [[GQTRegisterViewController alloc] init];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *valueDic = [responseStr JSONValue];
    int state = [[valueDic objectForKey:@"state"] integerValue];
    
    if (state == 200) {
        GQTUserInfo *userInfo = [[GQTUserInfo alloc] init];
        userInfo.userId = [[valueDic objectForKey:@"memberId"] integerValue];
        userInfo.areaId = [[valueDic objectForKey:@"areaId"] integerValue];
        userInfo.userLogin = [valueDic objectForKey:@"loginname"];
        userInfo.userNike = [valueDic objectForKey:@"username"];
        userInfo.userPhone = [valueDic objectForKey:@"phone"];
        userInfo.UserEmail = [valueDic objectForKey:@"email"];
        userInfo.userArea = [valueDic objectForKey:@"areaName"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:UserInfo];
        [[NSUserDefaults standardUserDefaults] setInteger: userInfo.userId forKey:@"memberId"];
        
        [APP_DELEGATE setUserInfo:userInfo];
        //跳转页面到主页面
        [self.navigationController popToRootViewControllerAnimated:YES];
        [userInfo release];
        
    }else{
        [UITools showAlert:@"登陆错误，请检查" delegate:nil];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络是否连接" delegate:nil];
}

@end
