//
//  GQTBookViewController.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GQTBookViewController.h"
#import "GQTMaticDetailCell.h"
#import "GQTCourseDetailViewController.h"
#import "ASIHTTPRequest.h"
#import "UITools.h"
#import "GQTBookInfo.h"
#import "SBJson.h"

#import "GQTCommons.h"

#import "GQTCourseListTableViewController.h"

#define BOOKLISTINFO @"%@?page=%d&row=%d"



@interface GQTBookViewController ()
{
    GQTCourseListTableViewController *listTable;
    GQTCateGoryViewController *categoryViewController;
}

@property (retain, nonatomic)  GQTCourseListTableViewController *listTable;
@property (retain, nonatomic) GQTCateGoryViewController *categoryViewController;
@end

@implementation GQTBookViewController

@synthesize categoryInfo;
@synthesize categoryArr;

@synthesize listTable;
@synthesize categoryViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    
    GQTCourseListTableViewController *listViewController = [[GQTCourseListTableViewController alloc] init];
    
    listViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:listViewController.view];
    listTable = listViewController;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [rightBtn setBackgroundImage:[GQTCommons getNavigationBarBackImage] forState:UIControlStateNormal];
    //    [rightBtn setBackgroundColor:[UIColor colorWithRed:39.0/255.0 green:131.0/255.0 blue:220.0/255.0 alpha:1]];
    [rightBtn setTitle:@"分类" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(getTheClassification) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    
    [GQTCommons setViewBackImage:self.view];
}

//拼命旋转 iOS 5
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

- (void)viewWillAppear:(BOOL)animated{

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 1;
    [tap addTarget:self action:@selector(handleSingleFingerEvent)];
    
    [self.view_category  addGestureRecognizer:tap];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleSingleFingerEvent{
    if (self.categoryViewController != nil) {
        [self.categoryViewController.view removeFromSuperview];
        self.categoryViewController = nil;
    }
    self.view_category.hidden = YES;
}

#pragma mark --
- (void)getTheClassification{
    if (self.categoryViewController != nil) {
        [self.categoryViewController.view removeFromSuperview];
        self.categoryViewController = nil;
        return;
    }
    
    NSURL *urlStr = [NSURL URLWithString:[CR_URL_BOOKCATEGORY stringByAppendingString:@"?code=001002"]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urlStr];
    request.timeOutSeconds = 15;
    request.delegate = self;
    [request startAsynchronous];
}


#pragma mark init

-(void)initNavigationBar
{
    self.navigationItem.title = @"书籍学习";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)dealloc {
    [listTable release];
    [categoryViewController release];
    
    [categoryArr release];
    [categoryInfo release];
    
    [_view_category release];
    [super dealloc];
}

- (void)viewDidUnload {
    
    [self setView_category:nil];
    [super viewDidUnload];
}

#pragma mark --
#pragma mark - request 
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [[[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *valueDic = [responseStr JSONValue];
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    
    if (state == 200) {
        NSString *code = [valueDic objectForKey:@"code"];
//        NSString *name = [valueDic objectForKey:@"name"];
//        NSString *type = [valueDic objectForKey:@"type"];
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
        NSArray *categoryList = [valueDic objectForKey:@"categorylist"];
        for (NSDictionary *temp in categoryList) {
            GQTCategoryInfo *category = [[GQTCategoryInfo alloc] init];
            category.categoryId = [[temp objectForKey:@"categoryId"] integerValue];
            category.categoryName = [temp objectForKey:@"categoryName"];
            category.categoryCode = [temp objectForKey:@"categoryCode"];
            category.categoryType = [temp objectForKey:@"categoryType"];
            category.hasNext = [[temp objectForKey:@"hasNext"] integerValue] == 1;
            [tempArr addObject:category];
            [category release];
        }
        self.categoryArr = tempArr;
        [tempArr release];
        //获取到分类后就把显示出来
        [self showCategoryInfo:[code isEqualToString:@"001002"]];
    }
}

- (void)showCategoryInfo:(BOOL)isTop{
    
    GQTCateGoryViewController *viewController = [[GQTCateGoryViewController alloc] init];
    viewController.categoryArr = self.categoryArr;
    if (isTop) {
        viewController.view.frame = CGRectMake(0, 0, 320, [GQTCateGoryViewController heightOfCategoryCount:[self.categoryArr count] isTopCategory:TRUE]);
        viewController.sigleLineShow = NO;
        self.categoryViewController = viewController;
        
    }else{
        CGFloat height = [GQTCateGoryViewController heightOfCategoryCount:[self.categoryArr count] isTopCategory:NO];
        viewController.view.frame = CGRectMake(60, (self.view.frame.size.height - height)/2, 200, height);
        viewController.sigleLineShow = YES;
        self.categoryViewController = viewController;
    }
    
    [viewController initCategoryPistion];
    viewController.delegate = self;
    
    if (isTop) {
        [self.view addSubview:viewController.view];
    }else{
        [self.view_category setHidden:NO];
        [self.view bringSubviewToFront:self.view_category];
        [self.view addSubview:viewController.view];
    }
    
    
    [viewController release];
}

- (void)categorySelect:(GQTCategoryInfo *)info{
    if (self.categoryViewController != nil) {
        [self.categoryViewController.view removeFromSuperview];
        self.categoryViewController = nil;
    }
    
    [self.view_category setHidden:YES];
    
    if (info.hasNext == YES) {
        NSString *urlStr = [NSString stringWithFormat:@"%@?code=%@",CR_URL_BOOKCATEGORY,info.categoryCode];
        NSURL *url = [NSURL URLWithString:urlStr];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        request.timeOutSeconds = 15;
        request.delegate = self;
        [request startAsynchronous];

    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@?code=%@",CR_URL_BOOKLIST_CATE,info.categoryCode];
        NSString *format = [urlStr stringByAppendingString:@"&page=%d&row=%d"];
        [listTable setRequestFormat:format requestMoreBy:RequestMoreByPageFromPage];
        [listTable reloadTableViewDataSource];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"连接失败，请检查网络连接" delegate:nil];
}

@end
