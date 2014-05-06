//
//  GQTLearningViewController.m
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTLearningViewController.h"

#import "GQTLearingTableViewController.h"
#import "SBJson.h"
#import "UITools.h"

#import "GQTSelectCource.h"
#import "MBProgressHUD.h"
#import "GQTCommons.h"


#define SUB_VIEW_HIGH           332
#define HEAD_HIGH               35

@interface GQTLearningViewController (){
    ASIHTTPRequest *m_request;
}

- (void)loadSubViewController;
- (void)changeSegmentView;


-(void)initNavigationBar;

@end

@implementation GQTLearningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if(subViewControllers == nil){
            subViewControllers = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        [self loadSubViewController];
        selectIndex = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *button = [[[UIButton alloc] init] autorelease];
    button.tag = 0;
    
    [self segmentedSelectClick:button];
    
    [self.courseBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.courseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.unLearnBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.unLearnBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.progressBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.progressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.complementBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.complementBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [GQTCommons setViewBackImage:self.contentScrollView];
    
    
    [self initNavigationBar];
    
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
    NSString *urlStr = [NSString stringWithFormat:@"http://42.121.236.161:8081/edu/mobile/user/studycenter.html?memberId=%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"memberId"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    m_request = [ASIHTTPRequest requestWithURL:url];
    m_request.delegate = self;
    [m_request setTimeOutSeconds:15];
    
    [m_request startAsynchronous];
}

-(void)initNavigationBar
{
    self.navigationItem.title = @"学习中心";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    if (m_request) {
        m_request.delegate = nil;
    }
    [subViewControllers release];
    
    [_selectView release];
    [_contentScrollView release];
    [_courseBtn release];
    [_unLearnBtn release];
    [_progressBtn release];
    [_complementBtn release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setSelectView:nil];
    [self setContentScrollView:nil];
    [self setCourseBtn:nil];
    [self setUnLearnBtn:nil];
    [self setProgressBtn:nil];
    [self setComplementBtn:nil];
    [super viewDidUnload];
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

#pragma mark - init
- (void)loadSubViewController{
    GQTLearingTableViewController *courseViewController = [[[GQTLearingTableViewController alloc] initWithNibName:@"GQTLearingTableViewController" bundle:nil] autorelease];
    [courseViewController setType:LearningTypeQualityCourses];
    
    GQTLearingTableViewController *notLearningViewController = [[[GQTLearingTableViewController alloc] initWithNibName:@"GQTLearingTableViewController" bundle:nil] autorelease];
    [notLearningViewController setType:LearningTypeNotLearning];
    
    GQTLearingTableViewController *progressViewController = [[[GQTLearingTableViewController alloc] initWithNibName:@"GQTLearingTableViewController" bundle:nil] autorelease];
    [progressViewController setType:LearningTypeInProgress];
    
    GQTLearingTableViewController *completedViewController = [[[GQTLearingTableViewController alloc] initWithNibName:@"GQTLearingTableViewController" bundle:nil] autorelease];
    [completedViewController setType:LearningTypeCompleted];
    
    [subViewControllers addObject:courseViewController];
    [subViewControllers addObject:notLearningViewController];
    [subViewControllers addObject:progressViewController];
    [subViewControllers addObject:completedViewController];
}


#pragma mark - segment select button click
- (IBAction)segmentedSelectClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    selectIndex = button.tag;
    
    self.contentScrollView.frame=CGRectMake(0, HEAD_HIGH, 320, self.contentScrollView.frame.size.height);
    self.contentScrollView.contentSize = CGSizeMake(320*[subViewControllers count], self.contentScrollView.frame.size.height);
    
    [self.contentScrollView setContentOffset:CGPointMake(320*selectIndex, 0) animated:NO];
    UITableViewController* subViewController=(UITableViewController*)[subViewControllers objectAtIndex:selectIndex];
    subViewController.view.frame=CGRectMake(selectIndex*320,0, 320,self.contentScrollView.frame.size.height);
    
    [self.contentScrollView addSubview:subViewController.view];
    [self.contentScrollView bringSubviewToFront:subViewController.view];
    
    [self changeSegmentView];
}

- (void)changeSegmentView{
    switch (selectIndex) {
        case 0:
            {
                self.courseBtn.selected = YES;
                self.unLearnBtn.selected = NO;
                self.progressBtn.selected = NO;
                self.complementBtn.selected = NO;
            }
            break;
        case 1:
            {
                self.courseBtn.selected = NO;
                self.unLearnBtn.selected = YES;
                self.progressBtn.selected = NO;
                self.complementBtn.selected = NO;
            }
            break;
        case 2:
            {
                self.courseBtn.selected = NO;
                self.unLearnBtn.selected = NO;
                self.progressBtn.selected = YES;
                self.complementBtn.selected = NO;
            }
            break;
        case 3:
            {
                self.courseBtn.selected = NO;
                self.unLearnBtn.selected = NO;
                self.progressBtn.selected = NO;
                self.complementBtn.selected = YES;
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - request delegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [request responseString];
    NSDictionary *valueDic = [responseStr JSONValue];
    
    NSInteger status = [[valueDic objectForKey:@"state"] integerValue];
    if (status == 200) {
        NSMutableArray *dataArra_tj = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *dataArra_wx = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *dataArra_xx = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *dataArra_wc = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSArray *course = [valueDic objectForKey:@"tjkc"];
        
        for (NSDictionary *temp in course) {
            GQTSelectCource *select = [[GQTSelectCource alloc] init];
            select.taskId = [[temp objectForKey:@"taskId"] integerValue];
            select.taskname = [temp objectForKey:@"taskName"];
            select.tasknote = [temp objectForKey:@"taskNote"];
            select.taskimage = [temp objectForKey:@"taskImage"];
            [dataArra_tj addObject:select];
            [select release];
        }
        
        NSArray *notLearn = [valueDic objectForKey:@"wxxkc"];
        for (NSDictionary *temp  in notLearn) {
            GQTSelectCource *select = [[GQTSelectCource alloc] init];
            select.taskId = [[temp objectForKey:@"taskId"] integerValue];
            select.taskname = [temp objectForKey:@"taskName"];
            select.tasknote = [temp objectForKey:@"taskNote"];
            select.taskimage = [temp objectForKey:@"taskImage"];
            [dataArra_wx addObject:select];
            [select release];
        }
        
        NSArray *progress = [valueDic objectForKey:@"xxzkc"];
        for (NSDictionary *temp  in progress) {
            GQTSelectCource *select = [[GQTSelectCource alloc] init];
            select.taskId = [[temp objectForKey:@"taskId"] integerValue];
            select.taskname = [temp objectForKey:@"taskName"];
            select.tasknote = [temp objectForKey:@"taskNote"];
            select.taskimage = [temp objectForKey:@"taskImage"];
            [dataArra_xx addObject:select];
            [select release];
        }
        
        NSArray *completed = [valueDic objectForKey:@"wckc"];
        for (NSDictionary *temp  in completed) {
            GQTSelectCource *select = [[GQTSelectCource alloc] init];
            select.taskId = [[temp objectForKey:@"taskId"] integerValue];
            select.taskname = [temp objectForKey:@"taskName"];
            select.tasknote = [temp objectForKey:@"taskNote"];
            select.taskimage = [temp objectForKey:@"taskImage"];
            [dataArra_wc addObject:select];
            [select release];
        }
        
        for (GQTLearingTableViewController *viewController in subViewControllers) {
            
            switch (viewController.type) {
                case LearningTypeQualityCourses:
                    {
                        viewController.dataArray = dataArra_tj;
                        [viewController.tableView reloadData];
                    }
                    break;
                case LearningTypeNotLearning:
                    {
                        viewController.dataArray = dataArra_wx;
                        [viewController.tableView reloadData];
                    }
                    break;
                case LearningTypeInProgress:
                    {
                        viewController.dataArray = dataArra_xx;
                        [viewController.tableView reloadData];
                    }
                    break;
                case LearningTypeCompleted:
                    {
                        viewController.dataArray = dataArra_wc;
                        [viewController.tableView reloadData];
                    }
                    break;
                default:
                    break;
            }
        }
        
        [dataArra_tj release];
        [dataArra_wx release];
        [dataArra_xx release];
        [dataArra_wc release];
        
    }
    m_request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络!!" delegate:nil];
    m_request = nil;
}
@end
