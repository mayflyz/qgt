//
//  GQTInformationViewController.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GQTInformationViewController.h"
#import "PRPComplexTableViewCell.h"

#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "GQTCouserBaseInfo.h"
#import "GQTSelectCource.h"
#import "UITools.h"
#import "EGOImageButton.h"

#import "MBProgressHUD.h"
#import "GQTCommons.h"

#import "GQTCourseDetailViewController.h"
#import "GQTInfoContenViewController.h"

@interface GQTInformationViewController (){
}

- (void)initbigImageScrollView;
@end

@implementation GQTInformationViewController

@synthesize dataArray;
@synthesize bigImageArray;

@synthesize complexCellNib;
@synthesize arrTitles;
@synthesize MaticDetailPage;

- (void)dealloc {
    [MaticDetailPage release];
    [arrTitles release];
    [complexCellNib release];
    [_scrollView_Title release];
    [_label_Title release];
    [_tableView_Info release];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavigationBar];
    
    //初始化图片
    [self initTitleView];
    
    GQTMaticDetailViewController *matic_ = [[GQTMaticDetailViewController alloc] initWithNibName:@"GQTMaticDetailViewController" bundle:nil];
    self.MaticDetailPage = matic_;
    [matic_ release];
    
     self.complexCellNib = nil;
    
    self.arrTitles = [NSMutableArray arrayWithObjects:@"圆梦计划",@"亲青训练营",@"志愿大讲堂",@"新媒体培训班", nil];
    self.label_Title.text = [arrTitles objectAtIndex:0];
    
    //网络请求
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud showWhileExecuting:@selector(requestFromServer) onTarget:self withObject:nil animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:hud];
    
    [hud release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setScrollView_Title:nil];
    [self setLabel_Title:nil];
    [self setTableView_Info:nil];
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

#pragma mark --
- (void)requestFromServer{
    NSURL *url = [NSURL URLWithString:CR_URL_SELECTCORCE];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    request.timeOutSeconds = 20;
    request.delegate = self;
    
    [request startAsynchronous];
    
    ASIHTTPRequest *requestImage = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:CR_URL_BIGIMAGE]];
    requestImage.timeOutSeconds = 20;
    requestImage.delegate = self;
    
    [requestImage setDidFinishSelector:@selector(getBigImageFinish:)];
    [requestImage setDidFailSelector:nil];
    [requestImage startAsynchronous];
}

#pragma mark init

-(void)initNavigationBar
{
    self.navigationItem.title = @"最新推荐";
    
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
    
    UIImage* image3 = [UIImage imageNamed:@"ico_search.png"];
    CGRect frameimg = CGRectMake(0, 0, 30, 30);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setImage:image3 forState:UIControlStateNormal];
    [someButton setBackgroundColor:[UIColor clearColor]];
    [someButton setBackgroundImage:[GQTCommons getNavigationBarBackImage] forState:UIControlStateNormal];
    
    [someButton addTarget:self action:@selector(clicked_search_btn:) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem=mailbutton;
    [someButton release];
    [mailbutton release];
}

-(void)initTitleView
{    self.scrollView_Title.contentSize = CGSizeMake(self.view.frame.size.width * 4, 90);
    self.scrollView_Title.pagingEnabled = YES;
    self.scrollView_Title.showsHorizontalScrollIndicator = NO;
    self.scrollView_Title.showsVerticalScrollIndicator = NO;
    self.scrollView_Title.scrollEnabled = YES;
    
    for (int i = 0; i < 4 ; i++) {
        UIImageView *imageView_ = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_nophoto.png"]];
        imageView_.tag = i;
        imageView_.frame = CGRectMake(self.view.frame.size.width * i + 100, 5, 130,90);
        [self.scrollView_Title addSubview:imageView_];
        [imageView_ release];
    }
}

- (void)initbigImageScrollView{
     self.scrollView_Title.contentSize = CGSizeMake(self.view.frame.size.width * [self.bigImageArray count], 90);
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];

    //替换掉幻灯片中的图片
    for (UIView *subView in [self.scrollView_Title subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    for (int i = 0; i < [self.bigImageArray count]; i++) {
        ImageInfo *image = [self.bigImageArray objectAtIndex:i];
        [array addObject:image.imageTitle];
        
        
        EGOImageButton *imageBtn = [EGOImageButton buttonWithType:UIButtonTypeCustom];
        [imageBtn setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
        imageBtn.tag = i;
        imageBtn.imageURL = [NSURL URLWithString:[GQTCommons getImageUrl:image.imageUrl]];
        [imageBtn setFrame:CGRectMake(self.view.frame.size.width *i + 100, 5, 130, 90)];
        [imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView_Title addSubview:imageBtn];
    }
    
    [self.arrTitles removeAllObjects];
    [self.arrTitles addObjectsFromArray:array];
    [array release];
    
    self.label_Title.text = [arrTitles objectAtIndex:0];
}

#pragma mark --

#pragma mark click

-(void)clicked_search_btn:(id)sender
{
    GCTSearchViewViewController *search_ = [[[GCTSearchViewViewController alloc] initWithNibName:@"GCTSearchViewViewController" bundle:nil] autorelease];

    search_.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:search_ animated:YES];
}

-(void)imageBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    ImageInfo *image = [self.bigImageArray objectAtIndex:btn.tag];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[GQTCommons getImageUrl:image.linkURL]]];
    
//    News跳转到新闻页面(targetId)
//    Task跳转到专题页面(targetId)
//    Course 跳转到课程详情页面(targetId)
//    Book跳转到电子书页面(targetId)
    if ([image.type isEqualToString:@"news"]) {
        
        GQTInfoContenViewController *viewController = [[GQTInfoContenViewController alloc] init];
        viewController.noticeId = [image.targetId integerValue];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }else if ([image.type isEqualToString:@"task"]){
        GQTSelectCource *selectCource = [[[GQTSelectCource alloc] init] autorelease];
        selectCource.taskId = [image.targetId integerValue];
        selectCource.taskimage = image.imageUrl;
        selectCource.taskname = image.imageTitle;
        selectCource.tasknote = image.note;
        
        GQTMaticDetailViewController *viewController = [[GQTMaticDetailViewController alloc] init];
        viewController.selectCource = selectCource;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
        
    }else if ([image.type isEqualToString:@"course"]){
        GQTBookInfo *book = [[[GQTBookInfo alloc] init] autorelease];
        book.bookId = [image.targetId integerValue];
        book.bookName = image.imageTitle;
        book.bookImage = image.imageUrl;
        book.bookNote = image.note;
        GQTCourseDetailViewController *detail_ = [[GQTCourseDetailViewController alloc] initWithNibName:@"GQTCourseDetailViewController" bundle:nil];
        detail_.bookInfo = book;
        detail_.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail_ animated:YES];
        [detail_ release];
    }else if ([image.type isEqualToString:@"book"]){
        //查看电子书信息,电子书仍然跳转到课程详情页面
        
        GQTBookInfo *book = [[[GQTBookInfo alloc] init] autorelease];
        book.bookId = [image.targetId integerValue];
        book.bookName = image.imageTitle;
        book.bookImage = image.imageUrl;
        book.bookNote = image.note;
        GQTCourseDetailViewController *detail_ = [[GQTCourseDetailViewController alloc] initWithNibName:@"GQTCourseDetailViewController" bundle:nil];
        detail_.bookInfo = book;
        detail_.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail_ animated:YES];
        [detail_ release];

    }else{
        return;
    }
    
}

#pragma mark --request delegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *responseStr = [request responseString];
    
    NSDictionary *valueDic = [responseStr JSONValue];
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    
//    NSInteger totalPage = [[valueDic objectForKey:@"totalpage"] integerValue];
//    NSInteger page = [[valueDic objectForKey:@"page"] integerValue];
//    NSInteger rows  = [[valueDic objectForKey:@"rows "] integerValue];
    
    NSMutableArray *selectArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (state == 200) {
        NSArray *list = [valueDic objectForKey:@"tasklist"];
        
        for (NSDictionary *temp in list) {
            GQTSelectCource *select = [[GQTSelectCource alloc] init];
            select.taskId = [[temp objectForKey:@"taskid"] integerValue];
            select.taskimage = [temp objectForKey:@"taskimage"];
            select.taskname = [temp objectForKey:@"taskname"];
            select.tasknote = [temp objectForKey:@"tasknote"];
            select.xxnum = [[temp objectForKey:@"xxnum"] integerValue];
            select.bxnum = [[temp objectForKey:@"bxnum"] integerValue];
            select.identityid = [[temp objectForKey:@"identityid"] integerValue];
            select.identityname = [temp objectForKey:@"identityname"];
            
            [selectArray addObject:select];
            [select release];
        }
    }
    
    self.dataArray = selectArray;
    [selectArray release];
    
    [self.tableView_Info reloadData];
}

//获取幻灯片数据成功
- (void)getBigImageFinish:(ASIHTTPRequest *)request{
    
    NSString *responseStr = [request responseString];
    
    NSDictionary *valueDic = [responseStr JSONValue];
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (state == 200) {
        NSArray *list = [valueDic objectForKey:@"list"];
        
        for (NSDictionary *temp in list) {
            ImageInfo *image = [[ImageInfo alloc] init];
            image.imageId = [[temp objectForKey:@"id"] integerValue];
            image.imageTitle = [temp objectForKey:@"title"];
            image.imageUrl = [temp objectForKey:@"image"];
            image.linkURL = [temp objectForKey:@"url"];
            image.targetId = [temp objectForKey:@"targetId"];
            image.type   = [temp objectForKey:@"type"];
            image.note   = [temp objectForKey:@"note"];
            
            [imageArray addObject:image];
            [image release];
        }
    }
    self.bigImageArray = imageArray;
    [imageArray release];
    
    [self performSelectorOnMainThread:@selector(initbigImageScrollView) withObject:nil waitUntilDone:NO];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    [UITools showAlert:@"网络有问题，请检查网络!!!" delegate:nil];
}

#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRPComplexTableViewCell *cell =
    [PRPComplexTableViewCell cellForTableView:tableView
                                      fromNib:self.complexCellNib];
    
    GQTSelectCource *selectCource = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.faceImage setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    
    NSString *imgURL = [GQTCommons getImageUrl:selectCource.taskimage];
    [cell.faceImage setImageURL:[NSURL URLWithString:imgURL]];
    
    cell.titleLabel.text = selectCource.taskname; // @"感悟十八大 青春正能量";
    cell.locationLabel.text = selectCource.tasknote; //@"为落实团中央常委会作出《关于深入学习宣传贯彻党的十八大精神，狠抓团的组织建设，团结动员广大团员青年在全面建成小康社会进程中充分发挥生力军作用的决议》，广泛深入学习宣传贯彻党的十八大精神的要";
    cell.dateLabel.text = [NSString stringWithFormat:@"本课程必修:%d章，选修:%d章",selectCource.bxnum,selectCource.xxnum];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GQTSelectCource *selectCource = [self.dataArray objectAtIndex:indexPath.row];
    GQTMaticDetailViewController *viewController = [[GQTMaticDetailViewController alloc] init];
    viewController.selectCource = selectCource;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
    
//    self.MaticDetailPage.selectCource = selectCource;
//    
//    self.MaticDetailPage.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:self.MaticDetailPage animated:YES];
}

//幻灯片的播放停止与否
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger iPage = (NSInteger) scrollView.contentOffset.x / self.view.frame.size.width;
    self.label_Title.text = [self.arrTitles objectAtIndex:iPage];
}

#pragma mark -
#pragma mark Accessors

- (UINib *)complexCellNib {
    if (complexCellNib == nil) {
        self.complexCellNib = [PRPComplexTableViewCell nib];
    }
    return complexCellNib;
}

@end
