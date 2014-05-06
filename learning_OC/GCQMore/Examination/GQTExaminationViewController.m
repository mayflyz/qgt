//
//  GQTExaminationViewController.m
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTExaminationViewController.h"

#import "GQTExamTableViewController.h"
#import "UITools.h"
#import "SBJson.h"

#import "GQTExamInfo.h"
#import "GQTCommons.h"

#import "MBProgressHUD.h"

#define SUB_VIEW_HIGH           332
#define HEAD_HIGH               35

@interface GQTExaminationViewController ()

- (void)loadExamSubViewController;
- (void)changeExaminColor;

-(void)initNavigationBar;

- (void)setsubViewFrameWhenIphone5;

@end

@implementation GQTExaminationViewController

@synthesize tableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if(subViewControllers == nil){
            subViewControllers = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        [self loadExamSubViewController];
        selectIndex = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIButton *button = [[UIButton alloc] init];
    button.tag = 0;
    [self examinationSelect:button];
    [button release];
    
    [self.complementBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.complementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self.unComplementBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.unComplementBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self initNavigationBar];
    
    [GQTCommons setViewBackImage:self.view];
    
    [self setsubViewFrameWhenIphone5];
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

- (void)setsubViewFrameWhenIphone5{
    //初始化主view 框架
    CGRect rect = CGRectMake(0, 0, 320, 35);
    self.view_main.frame = rect;
//    self.view_main.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    CGRect scrollRect = CGRectMake(0, 35, 320, iPhone5 ? 470 : 381);
    self.examContentScrollView.frame = scrollRect;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //网络请求
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud showWhileExecuting:@selector(requestFromServer) onTarget:self withObject:nil animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    
    [hud release];
    
}

- (void)requestFromServer{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?memberId=%d",CR_URL_EXAMCENTER,[[NSUserDefaults standardUserDefaults] integerForKey:@"memberId"]]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.delegate = self;
    request.timeOutSeconds = 20;
    [request startAsynchronous];
}

-(void)initNavigationBar
{
    self.navigationItem.title = @"考试查询";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [subViewControllers release];
    
    [_examContentScrollView release];
    [_complementBtn release];
    [_unComplementBtn release];
    [_view_main release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setExamContentScrollView:nil];
    [self setComplementBtn:nil];
    [self setUnComplementBtn:nil];
    [self setView_main:nil];
    [super viewDidUnload];
}

#pragma mark - 
- (IBAction)examinationSelect:(id)sender {
    UIButton *button =(UIButton *)sender;
    selectIndex = button.tag;
    
    self.examContentScrollView.frame=CGRectMake(0, HEAD_HIGH, 320, self.examContentScrollView.frame.size.height);
    self.examContentScrollView.contentSize = CGSizeMake(320*[subViewControllers count], self.examContentScrollView.frame.size.height);
    
    [self.examContentScrollView setContentOffset:CGPointMake(320*selectIndex, 0) animated:NO];
    UIViewController* subViewController=(UIViewController*)[subViewControllers objectAtIndex:selectIndex];
    subViewController.view.frame=CGRectMake(selectIndex*320,0, 320,self.examContentScrollView.frame.size.height);
    [self.examContentScrollView addSubview:subViewController.view];
    
    [self changeExaminColor];
}

#pragma mark - request DELegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
//    NSLog(@"exam responseStr %@",responseStr);
    NSDictionary *valueDic = [responseStr JSONValue];
    
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    
    if (state == 200) {
        NSMutableArray *dataArray_pass = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *dataArry_noPass = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray *passeArr = [valueDic objectForKey:@"passexamlist"];
        for (NSDictionary *temp in passeArr) {
            GQTExamInfo *exam = [[GQTExamInfo alloc] init];
            exam.examName = [temp objectForKey:@"papername"];
            exam.examScroe = [temp objectForKey:@"paperscore"];
            exam.examImage = [temp objectForKey:@"paperimage"];
            [dataArray_pass addObject:exam];
            [exam release];
        }
        
        NSArray *noPassArr = [valueDic objectForKey:@"nopassexamlist"];
        for (NSDictionary *temp in noPassArr) {
            GQTExamInfo *exam = [[GQTExamInfo alloc] init];
            exam.examName = [temp objectForKey:@"papername"];
            exam.examScroe = [temp objectForKey:@"paperscore"];
            exam.examImage = [temp objectForKey:@"paperimage"];
            [dataArry_noPass addObject:exam];
            [exam release];
        }
        
        for (GQTExamTableViewController *viewController in subViewControllers) {
            switch (viewController.type) {
                case ExameTypePass:
                    {
                        viewController.dataArray = dataArray_pass;
                        [viewController.tableView reloadData];
                    }
                    break;
                case ExameTypeNoPass:
                    {
                        viewController.dataArray = dataArry_noPass;
                        [viewController.tableView reloadData];
                    }
                    
                default:
                    break;
            }
        }
        
        [dataArray_pass release];
        [dataArry_noPass release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络" delegate:nil];
}

#pragma mark - 
- (void)loadExamSubViewController{
    GQTExamTableViewController *examViewController = [[GQTExamTableViewController alloc] initWithNibName:@"GQTExamTableViewController" bundle:nil];
    examViewController.type = ExameTypePass;
    
    GQTExamTableViewController *notViewController = [[GQTExamTableViewController alloc] initWithNibName:@"GQTExamTableViewController" bundle:nil];
    notViewController.type = ExameTypeNoPass;
    
    [subViewControllers addObject:examViewController];
    [subViewControllers addObject:notViewController];
    
    [examViewController release];
    [notViewController release];
}

- (void)changeExaminColor{
    switch (selectIndex) {
        case 0:
            {
                [self.complementBtn setSelected:YES];
                [self.unComplementBtn setSelected:NO];
            }
            break;
        case 1:
            {
                [self.complementBtn setSelected:NO];
                [self.unComplementBtn setSelected:YES];
            }
            break;
        default:
            break;
    }
}

@end
