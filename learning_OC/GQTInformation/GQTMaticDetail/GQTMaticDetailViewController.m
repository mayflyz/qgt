//
//  GQTMaticDetailViewController.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GQTMaticDetailViewController.h"
#import "GQTMaticDetailCell.h"
#import "GQTCourseDetailViewController.h"

#import "GQTCommons.h"
#import "NSObject+SBJson.h"
#import "UITools.h"

#import "MBProgressHUD.h"

@interface GQTMaticDetailViewController ()

- (void)requestFromServer;
- (void)setsubViewFrameWhenIphone5;

@end

@implementation GQTMaticDetailViewController

@synthesize dataArray_choice;
@synthesize dataArray_must;
@synthesize selectCource;
@synthesize pageType;
@synthesize dicInfo;
@synthesize complexCellNib;

- (void)dealloc {
    [dataArray_choice release];
    [dataArray_must release];
    [selectCource release];
    
    [complexCellNib release];
    [dicInfo release];
    [_iamge_Title release];
    [_label_Name release];
    [_label_tips release];
    [_btn_jianjie release];
    [_btn_bixiu release];
    [_btn_xuanxiu release];
    [_view_main release];
    [_view_jianjie release];
    [_view_bixiu release];
    [_view_xuanxiu release];
    [_label_type release];
    [_label_detail release];
    [_tableView_bixiu release];
    [_tableView_xuanxiu release];
    [_view_title release];
    [_scroll_jianjie release];
    [super dealloc];
}

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
    
    pageType = k_jianjie;
    
    self.complexCellNib = nil;
    dataArray_must = [[NSMutableArray alloc] initWithCapacity:0];
    dataArray_choice = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.iamge_Title setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [self.iamge_Title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:selectCource.taskimage]]];
    
    [self.label_Name setText:self.selectCource.taskname];
    [self.label_tips setText:[NSString stringWithFormat:@"必修%d章，选修%d章",self.selectCource.bxnum,self.selectCource.xxnum]];
    
    [self.label_type setText:@"推荐专题"];
    
    CGSize size = [self.selectCource.tasknote sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(250, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect rect = self.label_detail.frame;
    rect.size.height = size.height;
    self.label_detail.frame = rect;
    
    [self.label_detail setText:self.selectCource.tasknote];
    
    if (size.height > (290 + (iPhone5 ? 88 : 0))) {
        CGRect viewRect = self.view_jianjie.frame;
        viewRect.size.height = size.height + 35;
        self.view_jianjie.frame = viewRect;
    }

    
    [self.scroll_jianjie setContentSize:CGSizeMake(320, self.view_jianjie.frame.size.height)];
    
    [self setsubViewFrameWhenIphone5];
    
    //网络请求
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.removeFromSuperViewOnHide = YES;
    [hud showWhileExecuting:@selector(requestFromServer) onTarget:self withObject:nil animated:YES];
    [self.view addSubview:hud];
    
    [hud release];
}

- (void)setsubViewFrameWhenIphone5{
    //初始化主view 框架
    CGRect mainRect = self.view_main.frame;
    mainRect.size.height = iPhone5 ? 414 : 326;
    self.view_main.frame = mainRect;
    
    CGRect rect = self.view_jianjie.frame;
    rect.size.height = iPhone5 ? 414 :326;
    
    self.view_jianjie.frame = rect;
    self.view_bixiu.frame = rect;
    self.view_xuanxiu.frame = rect;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view_main.backgroundColor = [UIColor blueColor];
    
    [self exchangeViewMain];
    
    [self initNavigationBar];
    
}

- (void)requestFromServer{
    NSString *urlStr = [NSString stringWithFormat:@"%@?id=%d",CR_URL_SELECTCONTENT,self.selectCource.taskId];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 15;
    request.delegate = self;
    [request startAsynchronous];
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

- (void)viewDidUnload {
    [self setIamge_Title:nil];
    [self setLabel_Name:nil];
    [self setLabel_tips:nil];
    [self setBtn_jianjie:nil];
    [self setBtn_bixiu:nil];
    [self setBtn_xuanxiu:nil];
    [self setView_main:nil];
    [self setView_jianjie:nil];
    [self setView_bixiu:nil];
    [self setView_xuanxiu:nil];
    [self setLabel_type:nil];
    [self setLabel_detail:nil];
    [self setTableView_bixiu:nil];
    [self setTableView_xuanxiu:nil];
    [self setView_title:nil];
    [self setScroll_jianjie:nil];
    [super viewDidUnload];
}

#pragma mark --

#pragma mark init

-(void)initNavigationBar
{
    self.navigationItem.title = @"专题详情";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark --

#pragma mark method

-(void)exchangeViewMain
{
    switch (self.pageType) {
        case k_jianjie:
        {
            self.view_jianjie.hidden = NO;
            self.view_bixiu.hidden = YES;
            self.view_xuanxiu.hidden = YES;
            
            self.btn_jianjie.titleLabel.textColor = [UIColor redColor];
            self.btn_bixiu.titleLabel.textColor = [UIColor greenColor];
            self.btn_xuanxiu.titleLabel.textColor = [UIColor greenColor];
        }
            break;
        case k_bixiu:
        {
            self.view_jianjie.hidden = YES;
            self.view_bixiu.hidden = NO;
            self.view_xuanxiu.hidden = YES;
            
            self.btn_jianjie.titleLabel.textColor = [UIColor greenColor];
            self.btn_bixiu.titleLabel.textColor = [UIColor redColor];
            self.btn_xuanxiu.titleLabel.textColor = [UIColor greenColor];
            
            [self.tableView_bixiu reloadData];
        }
            break;
        case k_xuanxiu:
        {
            self.view_jianjie.hidden = YES;
            self.view_bixiu.hidden = YES;
            self.view_xuanxiu.hidden = NO;
            
            self.btn_jianjie.titleLabel.textColor = [UIColor greenColor];
            self.btn_bixiu.titleLabel.textColor = [UIColor greenColor];
            self.btn_xuanxiu.titleLabel.textColor = [UIColor redColor];
            
            [self.tableView_xuanxiu reloadData];
        }
            break;
        default:
            break;
    }
}

#pragma mark --

#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (pageType) {
        case k_bixiu:
            return [self.dataArray_must count];
            break;
        case k_xuanxiu:
            return [self.dataArray_choice count];
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GQTMaticDetailCell *cell =
    [GQTMaticDetailCell cellForTableView:tableView
                                      fromNib:self.complexCellNib];
    
    switch (pageType) {
        case k_bixiu:
            {
                GQTBookInfo *book = [self.dataArray_must objectAtIndex:indexPath.row];
                [cell.image_title setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
                [cell.image_title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:book.bookImage]]];
                cell.label_title.text = book.bookName;//@"共青团要做好新形势下的青年群众工作";
                cell.label_zuozhe.text = [NSString stringWithFormat:@"作者：%@",book.bookAuthor]; // @"作者：练月琴";
                
                cell.label_jianjie.text = [NSString stringWithFormat:@"简介：%@",book.bookNote]; //@"简介：暂无简介";
                cell.label_type.text = book.type == CourseTypeBook ? @"电子书" :@"视频";
            }
            break;
        case k_xuanxiu:
            {
                GQTBookInfo *book = [self.dataArray_choice objectAtIndex:indexPath.row];
                [cell.image_title setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
                [cell.image_title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:book.bookImage]]];
                cell.label_title.text = book.bookName;//@"共青团要做好新形势下的青年群众工作";
                cell.label_zuozhe.text = [NSString stringWithFormat:@"作者：%@",book.bookAuthor]; // @"作者：练月琴";
                
                cell.label_jianjie.text = [NSString stringWithFormat:@"简介：%@",book.bookNote]; //@"简介：暂无简介";
                cell.label_type.text = book.type == CourseTypeBook ? @"电子书" :@"视频";
            }
            break;
        default:
            //
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GQTBookInfo *book = nil;
    
    switch (pageType) {
        case k_bixiu:
            {
                book = [self.dataArray_must objectAtIndex:indexPath.row];
            }
            break;
        case k_xuanxiu:
            {
                book = [self.dataArray_choice objectAtIndex:indexPath.row];
            }
            break;
        default:
            //
            break;
    }
    
    GQTCourseDetailViewController *detail_ = [[GQTCourseDetailViewController alloc] initWithNibName:@"GQTCourseDetailViewController" bundle:nil];
    detail_.bookInfo = book;
    detail_.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail_ animated:YES];
    [detail_ release];
}


#pragma mark --

#pragma mark click

- (IBAction)click_jianjie_btn:(id)sender {
    self.pageType = k_jianjie;
    [self exchangeViewMain];
}

- (IBAction)click_xuanxiu_btn:(id)sender {
    self.pageType = k_xuanxiu;
    [self exchangeViewMain];
}

- (IBAction)click_bixiu_btn:(id)sender {
    self.pageType = k_bixiu;
    [self exchangeViewMain];
}

#pragma mark -
#pragma mark Accessors

- (UINib *)complexCellNib {
    if (complexCellNib == nil) {
        self.complexCellNib = [GQTMaticDetailCell nib];
    }
    return complexCellNib;
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *string = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *valueDic = [string JSONValue];
    
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    
    if (state == 200) {
        [self.dataArray_must removeAllObjects];
        [self.dataArray_choice removeAllObjects];
        
        NSInteger taskid = [[valueDic objectForKey:@"taskid"] integerValue];
        NSString *message = [valueDic objectForKey:@"message"];
        
        NSString *taskimage = [valueDic objectForKey:@"taskimage"];
        [self.iamge_Title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:taskimage]]];
        
        NSString *tasknote = [valueDic objectForKey:@"tasknote"];
        self.label_detail.text = tasknote;
        
        NSString *taskname = [valueDic objectForKey:@"taskname"];
        self.label_Name.text = taskname;
        
        NSArray *mustbookList = [valueDic objectForKey:@"mustbooklist"];
        for (NSDictionary *temp in mustbookList) {
            
            GQTBookInfo *course = [[GQTBookInfo alloc] init];
            course.bookId = [[temp objectForKey:@"mustbookid"] integerValue];
            course.bookName = [temp objectForKey:@"mustbookname"];
            course.bookNote = [temp objectForKey:@"mustbooknote"];
            course.bookAuthor = [temp objectForKey:@"mustbookauthor"];
            course.bookImage = [temp objectForKey:@"mustbookimage"];
            course.type = CourseTypeBook;
            
            [self.dataArray_must addObject:course];
            [course release];
        }
        
        NSArray *mustCourseList = [valueDic objectForKey:@"mustcourselist"];
        for (NSDictionary *temp in mustCourseList) {
            GQTBookInfo *course = [[GQTBookInfo alloc] init];
            course.bookId = [[temp objectForKey:@"mustcourseid"] integerValue];
            course.bookName = [temp objectForKey:@"mustcoursename"];
            course.bookNote = [temp objectForKey:@"mustcoursenote"];
            course.bookAuthor = [temp objectForKey:@"mustteachername"];
            course.bookImage = [temp objectForKey:@"mustcourseimage"];
            course.teacherId = [[temp objectForKey:@"mustteacherid"] integerValue];
            course.teacherName = [temp objectForKey:@"mustteachername"];
            course.type = CourseTypeVideo;
            
            [self.dataArray_must addObject:course];
            [course release];
        }
        
        NSArray *choicebooklist = [valueDic objectForKey:@"choicebooklist"];
        for (NSDictionary *temp in choicebooklist) {
            
            GQTBookInfo *course = [[GQTBookInfo alloc] init];
            course.bookId = [[temp objectForKey:@"choicebookid"] integerValue];
            course.bookName = [temp objectForKey:@"choicebookname"];
            course.bookNote = [temp objectForKey:@"choicebooknote"];
            course.bookAuthor = [temp objectForKey:@"choicebookauthor"];
            course.bookImage = [temp objectForKey:@"choicebookimage"];
            course.type = CourseTypeBook;
            
            [self.dataArray_choice addObject:course];
            [course release];

        }
        
        NSArray *choicecourselist = [valueDic objectForKey:@"choicecourselist"];
        for (NSDictionary *temp in choicecourselist) {
            
            GQTBookInfo *course = [[GQTBookInfo alloc] init];
            course.bookId = [[temp objectForKey:@"choicecourseid"] integerValue];
            course.bookName = [temp objectForKey:@"choicecoursename"];
            course.bookNote = [temp objectForKey:@"choicecoursenote"];
            course.bookAuthor = [temp objectForKey:@"choiceteachername"];
            course.bookImage = [temp objectForKey:@"choicecourseimage"];
            course.teacherId = [[temp objectForKey:@"choiceteacherid"] integerValue];
            course.teacherName = [temp objectForKey:@"choiceteachername"];
            course.type = CourseTypeVideo;
            
            [self.dataArray_choice addObject:course];
            [course release];
        }
        
    }
    [self.tableView_bixiu reloadData];
    [self.tableView_xuanxiu reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络" delegate:nil];
}
@end
