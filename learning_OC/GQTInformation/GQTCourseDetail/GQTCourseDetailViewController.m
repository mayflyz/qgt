//
//  GQTCourseDetailViewController.m
//  learning_OC
//
//  Created by viktyz on 13-3-18.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GQTCourseDetailViewController.h"
#import "MediaPlayer/MediaPlayer.h"

#import "GQTCommons.h"

#import "GQTBookChapterListViewController.h"

@interface GQTCourseDetailViewController ()

- (void)setsubViewFrameWhenIphone5;

@end

@implementation GQTCourseDetailViewController

@synthesize bookInfo;
@synthesize PageType;
@synthesize dicInfo;
@synthesize bookChapterList;

- (void)dealloc {
    [bookChapterList release];
    [dicInfo release];
    [_image_title release];
    [_btn_jianjie release];
    [_btn_keshi release];
    [_label_Title release];
    [_view_jianjie release];
    [_view_keshi release];
    [_label_zuozhe release];
    [_label_leixing release];
    [_label_jianjie release];
    [_view_main release];
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
    // Do any additional setup after loading the view from its nib.
    
    //初始话标题
    self.label_Title.text = self.bookInfo.bookName;
    self.label_zuozhe.text = self.bookInfo.bookAuthor;
    
    [self.image_title setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [self.image_title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:self.bookInfo.bookImage]]];
    
    //初始化简介页面
    [self.label_leixing setText:self.bookInfo.categoryName];
    
    CGSize size = [self.bookInfo.bookNote sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(250, 2000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect rect = self.label_jianjie.frame;
    rect.size.height = size.height;
    self.label_jianjie.frame = rect;
    
    if (size.height > 290) {
        CGRect viewRect = self.view_jianjie.frame;
        viewRect.size.height = size.height + 36;
        self.view_jianjie.frame = viewRect;
    }
    
    [self.label_jianjie setText:self.bookInfo.bookNote];
    
    PageType = k_Course_jianjie;
    
    [self initNavigationBar];
    
    [self setsubViewFrameWhenIphone5];
    
    //添加课时list
    GQTBookChapterListViewController *list = [[GQTBookChapterListViewController alloc] init];
    list.book = self.bookInfo;
    list.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [list.view setFrame:CGRectMake(0, 0, self.view_keshi.frame.size.width, self.view_keshi.frame.size.height)];
    [self.view_keshi addSubview:list.view];
    self.bookChapterList = list;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self exchangeViewMain];
}


- (void)viewDidUnload {
    [self setImage_title:nil];
    [self setBtn_jianjie:nil];
    [self setBtn_keshi:nil];
    [self setLabel_Title:nil];
    [self setView_jianjie:nil];
    [self setView_keshi:nil];
    [self setLabel_zuozhe:nil];
    [self setLabel_leixing:nil];
    [self setLabel_jianjie:nil];
    [self setView_main:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown;
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

- (void)setsubViewFrameWhenIphone5{
    //初始化主view 框架
    CGRect mainRect = self.view_main.frame;
    mainRect.size.height = iPhone5 ? 414 : 326;
    self.view_main.frame = mainRect;
    
    CGRect rect = self.view_jianjie.frame;
    rect.size.height = iPhone5 ? 414 :326;
    
    self.view_jianjie.frame = rect;
    self.view_keshi.frame = rect;
}

#pragma mark init

-(void)initNavigationBar
{
    self.navigationItem.title = @"课程详情";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark --

#pragma mark method

-(void)exchangeViewMain
{
    switch (self.PageType) {
        case k_Course_jianjie:
        {
            self.view_jianjie.hidden = NO;
            self.view_keshi.hidden = YES;
            
            self.btn_jianjie.titleLabel.textColor = [UIColor redColor];
            self.btn_keshi.titleLabel.textColor = [UIColor greenColor];
        }
            break;
        case k_Course_keshi:
        {
            self.view_jianjie.hidden = YES;
            self.view_keshi.hidden = NO;
            
            self.btn_jianjie.titleLabel.textColor = [UIColor greenColor];
            self.btn_keshi.titleLabel.textColor = [UIColor redColor];
            
        }
            break;
        default:
            break;
    }
}


#pragma mark --

#pragma mark click

- (IBAction)click_jianjie_btn:(id)sender {
    self.pageType = k_Course_jianjie;
    [self exchangeViewMain];
}

- (IBAction)click_keshi_btn:(id)sender {
    self.pageType = k_Course_keshi;
    [self exchangeViewMain];
}
@end
