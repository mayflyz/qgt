//
//  GQTRegisterViewController.m
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTRegisterViewController.h"

#import "UITools.h"
#import "MBProgressHUD.h"
#import "NSObject+SBJson.h"
#import "GQTCommons.h"
#import "GQTAreaSelectViewController.h"
#import "AppDelegate.h"

#define UIScrollViewHeight (iPhone5 ? 504 : 416)

@interface GQTRegisterViewController (){
    CGFloat keyBoardHeigh;
    
    GQTAreaSelectViewController *m_areaSelectViewController;
    GQTTypeSelectViewController *m_typeSelectViewController;
}

@property (retain, nonatomic) GQTAreaSelectViewController *m_areaSelectViewController;
@property (retain, nonatomic) GQTTypeSelectViewController *m_typeSelectViewController;

-(void) keyboardWillShow:(NSNotification *)note;

@end

@implementation GQTRegisterViewController

@synthesize currentView;
@synthesize groupInfo;
@synthesize typeInfo;

@synthesize m_areaSelectViewController;
@synthesize m_typeSelectViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        keyBoardHeigh = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    GQTAreaSelectViewController *areaSelect = [[GQTAreaSelectViewController alloc] init];
    areaSelect.delegate = self;
    self.m_areaSelectViewController = areaSelect;
    [areaSelect release];
    
    GQTTypeSelectViewController *typeSelect = [[GQTTypeSelectViewController alloc] init];
    typeSelect.delegate = self;
    self.m_typeSelectViewController = typeSelect;
    [typeSelect release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    //添加聊天页面的手势处理
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer release];
    
    [self.scroll_content setContentSize:CGSizeMake(320, 480)];
    [self initNavigationBar];
    
    [GQTCommons setViewCornerRadius:self.backimageView];
    [GQTCommons setViewCornerRadius:self.backImage1];
    [GQTCommons setViewCornerRadius:self.backImage2];
    [GQTCommons setViewCornerRadius:self.backImage3];
    [GQTCommons setViewCornerRadius:self.backImage4];
    [GQTCommons setViewCornerRadius:self.backImage5];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)initNavigationBar{
    self.navigationItem.title = @"注册";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
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

- (void)dealloc {
    [m_areaSelectViewController release];
    [m_typeSelectViewController release];
    
    [_scroll_content release];
    [_registerBtn release];
    [_accountImageView release];
    [_nikeImageView release];
    [_phoneImageView release];
    [_passwordImageView release];
    [_confirmPassword release];
    [_text_account release];
    [_text_phoneNumber release];
    [_text_nike release];
    [_text_password release];
    [_text_confirmPassword release];
    [_areaSelectBtn release];
    [_backimageView release];
    [_label_area release];
    [_backImage1 release];
    [_backImage2 release];
    [_backImage3 release];
    [_backImage4 release];
    [_backImage5 release];
    [_typeSelectBtn release];
    [_label_typeInfo release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setScroll_content:nil];
    [self setRegisterBtn:nil];
    [self setAccountImageView:nil];
    [self setNikeImageView:nil];
    [self setPhoneImageView:nil];
    [self setPasswordImageView:nil];
    [self setConfirmPassword:nil];
    [self setText_account:nil];
    [self setText_phoneNumber:nil];
    [self setText_nike:nil];
    [self setText_password:nil];
    [self setText_confirmPassword:nil];
    [self setAreaSelectBtn:nil];
    [self setBackimageView:nil];
    [self setLabel_area:nil];
    [self setBackImage1:nil];
    [self setBackImage2:nil];
    [self setBackImage3:nil];
    [self setBackImage4:nil];
    [self setBackImage5:nil];
    [self setTypeSelectBtn:nil];
    [self setLabel_typeInfo:nil];
    [super viewDidUnload];
}

- (IBAction)registerBtnClick:(id)sender {
    
    if (self.text_account.text.length <= 0) {
        [UITools showAlert:@"邮箱账户不能为空" delegate:nil];
        [self.text_account becomeFirstResponder];
        return;
    }
    
    NSString * regex = @"1[0-9]{10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self.text_phoneNumber.text];
    
    if (!isMatch) {
        [UITools showAlert:@"输入的手机号码不正确" delegate:nil];
    }
    
    NSString * regexPWD = @"^[A-Za-z0-9]{6,15}$";
    NSPredicate *predPWD = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPWD];
    BOOL isMatchPWD = [predPWD evaluateWithObject:self.text_password.text];
    if (!isMatchPWD) {
        [UITools showAlert:@"密码不允许包含特殊字符" delegate:nil];
    }

    if (![self.text_confirmPassword.text isEqualToString:self.text_password.text]) {
        [UITools showAlert:@"前后输入的密码不一致" delegate:nil];
    }
    
    if (self.text_nike.text.length <= 0) {
        [UITools showAlert:@"昵称不能为空" delegate:nil];
        [self.text_nike becomeFirstResponder];
        return;
    }
    
    if (self.text_password.text.length <= 0) {
        [UITools showAlert:@"密码不能为空" delegate:nil];
        [self.text_password becomeFirstResponder];
        return;
    }
    
    if (self.text_confirmPassword.text.length <= 0) {
        [UITools showAlert:@"确认密码不能为空" delegate:nil];
        [self.text_confirmPassword becomeFirstResponder];
        return;
    }

    //网络请求
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud showWhileExecuting:@selector(requestFromServer) onTarget:self withObject:nil animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    
    [hud release];
}

- (IBAction)areaSelectClick:(id)sender {
//    GQTAreaSelectViewController *viewController = [[GQTAreaSelectViewController alloc] init];
//    viewController.delegate = self;
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//    [viewController release];
    
    self.m_areaSelectViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.m_areaSelectViewController animated:YES];
}

- (IBAction)typeSelectClick:(id)sender {
//    GQTTypeSelectViewController *viewController = [[GQTTypeSelectViewController alloc] init];
//    viewController.delegate = self;
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//    [viewController release];
    
    self.m_typeSelectViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:self.m_typeSelectViewController animated:YES];
    
}

- (void)requestFromServer{
    
    NSURL *url = [NSURL URLWithString:CR_URL_REGISTER];
    ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
    
    [formRequest setPostValue:self.text_account.text forKey:@"email"];
    [formRequest setPostValue:self.text_nike.text forKey:@"username"];
    [formRequest setPostValue:self.text_phoneNumber.text forKey:@"phone"];
    [formRequest setPostValue:self.text_password.text forKey:@"password"];
    NSString *groupId = [NSString stringWithFormat:@"%d",[[self.groupInfo objectForKey:@"id"] integerValue]];
    [formRequest setPostValue:groupId forKey:@"groupId"];
    [formRequest setPostValue:[NSString stringWithFormat:@"%d",self.typeInfo.typeId] forKey:@"typeId"];
    
    formRequest.delegate = self;
    formRequest.timeOutSeconds = 20;
    [formRequest startAsynchronous];
    
}

#pragma mark - keyboard dismiss
- (void)dismissKeyBoard{
    [self.view endEditing:YES];
}

#pragma mark -
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.currentView = textField;
    
    CGFloat offset = textField.frame.origin.y + textField.frame.size.height + keyBoardHeigh - UIScrollViewHeight;
    
    [self.scroll_content setContentOffset:CGPointMake(0, offset < 0 ? 0 : offset)   animated:YES];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
       
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.text_account) {
        
    }else if (textField == self.text_nike){
        
    }else if(textField == self.text_phoneNumber){
        
    }else if (textField == self.text_password){
        
    }else if (textField == self.text_confirmPassword){
        
    }
}

- (void)areaSelected:(NSDictionary *)valueDic{
    self.groupInfo = valueDic;
    self.label_area.text = [valueDic objectForKey:@"name"];
}

- (void)typeSelect:(GQTypeInfo *)typInfo{
    self.typeInfo = typInfo;
    self.label_typeInfo.text = typeInfo.typeName;
}

#pragma mark - ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *valueDic = [responseStr JSONValue];
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    
    if (state == 200) {
        GQTUserInfo *info = [[GQTUserInfo alloc] init];
        info.userId = [[valueDic objectForKey:@"memberId"] integerValue];
        info.userLogin = self.text_account.text;
        info.userNike = self.text_nike.text;
        info.userPhone = self.text_phoneNumber.text;
        info.areaId = self.typeInfo.typeId;
        info.userArea = [self.groupInfo objectForKey:@"name"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:UserInfo];
        [[NSUserDefaults standardUserDefaults] setInteger:info.userId forKey:@"memberId"];
        
        [APP_DELEGATE setUserInfo:info];
        
        [self.navigationController popToRootViewControllerAnimated:NO];
        [info release];
        
    }else{
         [UITools showAlert:[valueDic objectForKey:@"message"] delegate:nil];
//         [UITools showAlert:@"注册账户信息失败，请重试" delegate:nil];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络是否连接" delegate:nil];
}

-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    keyBoardHeigh = keyboardBounds.size.height;
    
    CGFloat height = self.currentView.frame.origin.y + self.currentView.frame.size.height;
    
    CGFloat changeHeight = keyboardBounds.size.height + height - UIScrollViewHeight;
    
    [self.scroll_content setContentOffset:CGPointMake(0, changeHeight < 0 ? 0 : changeHeight)   animated:YES];
}

-(void) keyboardWillHide:(NSNotification *)note{
    keyBoardHeigh = 0;

    [self.scroll_content setContentOffset:CGPointMake(0, 0) animated:YES];
}
@end
