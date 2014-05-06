//
//  GQTFeedbackViewController.m
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTFeedbackViewController.h"
#import "GQTCommons.h"

#import <QuartzCore/QuartzCore.h>

@interface GQTFeedbackViewController ()

- (void)initNavigationBar;

@end

@implementation GQTFeedbackViewController
@synthesize pickerArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pickerArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    
    [self.btn_opinios setTitle:@"提 交" forState:UIControlStateNormal];
    [GQTCommons setViewBackImage:self.view];
    NSArray *array = [NSArray arrayWithObjects:@"功能意见",@"界面意见",@"操作意见",@"流量问题",@"视频质量",@"其它意见", nil];
    [pickerArr addObjectsFromArray:array];
    
    [self initViewControl];
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

//为了支持iOS6
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
    self.navigationItem.title = @"在线反馈";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)initViewControl{
    self.text_feedConetn.layer.masksToBounds = YES;
    self.text_feedConetn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.text_feedConetn.layer.cornerRadius = 0.5;
    self.text_feedConetn.layer.borderWidth = 2;
    
    CGRect scrollRect = self.scrollView_content.frame;
    scrollRect.size.height += (iPhone5 ? 88 : 0);
    self.scrollView_content.frame = scrollRect;
    
    
    CGRect rect = self.pick_view.frame;
    rect.origin.y += (iPhone5 ? 44 : 0);
    self.pick_view.frame = rect;
    [self.view bringSubviewToFront:self.pick_view];
}

- (void)dealloc {
    [pickerArr release];
    
    [_laebl_feedType release];
    [_label_feedContent release];
    [_text_feedConetn release];
    [_label_contactWay release];
    [_field_contactWay release];
    [_btn_opinios release];
    [_pick_view release];
    [_picker_select release];
    [_scrollView_content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLaebl_feedType:nil];
    [self setLabel_feedContent:nil];
    [self setText_feedConetn:nil];
    [self setLabel_contactWay:nil];
    [self setField_contactWay:nil];
    [self setBtn_opinios:nil];
    [self setPick_view:nil];
    [self setPicker_select:nil];
    [self setScrollView_content:nil];
    [super viewDidUnload];
}

- (IBAction)opiniosBtnClick:(id)sender {
    [self.view endEditing:YES];
    
    [self.pick_view setHidden:NO];
}

- (IBAction)pickBtnClick:(id)sender {
    [self.pick_view setHidden:YES];
}

- (void)dismissKeyBoard{
    [self.view endEditing:YES];
    
    [self.pick_view setHidden:YES];
}

#pragma mark - picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = [pickerArr objectAtIndex:row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.btn_opinios setTitle:[pickerArr objectAtIndex:row] forState:UIControlStateNormal];
    selectType = row;
}

#pragma mark - keyboard notification to show
- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboardRect;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
//    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardRect = [self.view convertRect:keyboardRect toView:nil];
    
    CGFloat changeHeight = 0;
    if (tag == 201301) {
        changeHeight = self.text_feedConetn.frame.origin.y + self.text_feedConetn.frame.size.height -  keyboardRect.size.height;
    }else if (tag == 201302){
        changeHeight = self.field_contactWay.frame.origin.y + self.field_contactWay.frame.size.height -  keyboardRect.size.height;
    }
    
    [self.scrollView_content setContentOffset:CGPointMake(0, changeHeight < 0 ? 0 : changeHeight) animated:YES];
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [self.scrollView_content setContentOffset:CGPointMake(0, 0) animated:YES];
    
}


#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    tag = textField.tag;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

#pragma mark - textView Delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    tag = textView.tag;
}
@end
