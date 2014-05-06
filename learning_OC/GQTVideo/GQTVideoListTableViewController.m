//
//  GQTCourseListTableViewController.m
//  learning_OC
//
//  Created by test on 3/21/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTVideoListTableViewController.h"

#import "GQTMaticDetailCell.h"
#import "GQTBookInfo.h"
#import "GQTCourseDetailViewController.h"
#import "GQTCommons.h"

#import "AppDelegate.h"
#import "NSObject+SBJson.h"

#define BOOKLISTINFO @"%@?page=%d&row=%d"

@interface GQTVideoListTableViewController ()

- (void)handleJsonStr:(NSString *)jsonStr;
@end

@implementation GQTVideoListTableViewController

@synthesize complexCellNib;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.numberOfDataPerPage = 9;
    }
    
    return self;
}

- (void)viewDidLoad
{
    NSString *format = [CR_URL_ALLVIDEO stringByAppendingString:@"?page=%d&row=%d"];
    [self setRequestFormat:format requestMoreBy:RequestMoreByPageFromPage];
    
    [super viewDidLoad];    //需要一个连接去获取数据
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GQTMaticDetailCell *cell =
    [GQTMaticDetailCell cellForTableView:tableView
                                 fromNib:self.complexCellNib];
    
    GQTBookInfo *book = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.image_title setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [cell.image_title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:book.bookImage]]];
    
    cell.label_title.text = book.bookName; //@"共青团要做好新形势下的青年群众工作";
    cell.label_zuozhe.text = [NSString stringWithFormat:@"作者：%@",book.bookAuthor]; //@"作者：练月琴";
    cell.label_jianjie.text = @"简介：暂无简介";
    cell.label_type.text = @"视频";
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GQTBookInfo *book = [self.dataArray objectAtIndex:indexPath.row];
    
    GQTCourseDetailViewController *detail_ = [[GQTCourseDetailViewController alloc] initWithNibName:@"GQTCourseDetailViewController" bundle:nil];
    detail_.bookInfo = book;
    detail_.hidesBottomBarWhenPushed = YES;
    
    [[APP_DELEGATE selectedNavigationController] pushViewController:detail_ animated:YES];
    [detail_ release];
}


- (void)loadDataRequestSuccess:(ASIHTTPRequest *)request{
    NSString *string=[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    
    [self handleJsonStr:string];
}

#pragma mark - handle json str parse
- (void)handleJsonStr:(NSString *)jsonStr{
    NSMutableDictionary *valueDic = [jsonStr JSONValue];
    
//    NSLog(@"%@",[valueDic valueForKey:@"courselist"]);
    
    NSInteger status = [[valueDic objectForKey:@"state"] integerValue];
    //    NSInteger recordCount = [[valueDic objectForKey:@"recordCount"] integerValue];
    //    NSInteger row = [[valueDic objectForKey:@"row"] integerValue];  //当前总页数
    NSMutableArray *bookArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (status == 200) {
        NSArray *list = [valueDic objectForKey:@"courselist"];
        
        for (NSDictionary *temp in list) {
            GQTBookInfo *book = [[GQTBookInfo alloc] init];
            book.bookId = [[temp objectForKey:@"courseId"] integerValue];
            book.bookName = [temp objectForKey:@"courseName"];
            book.bookImage = [temp objectForKey:@"courseImage"];
            book.bookAuthor = [temp objectForKey:@"teacherName"];
            book.bookNote = [temp objectForKey:@"courseNote"];
            book.categoryId = [[temp objectForKey:@"categoryId"] integerValue];
            book.categoryName = [temp objectForKey:@"categoryName"];
            book.categoryCode = [temp objectForKey:@"categoryCode"];
            book.type = CourseTypeVideo;
            
            [bookArr addObject:book];
            [book release];
        }
    }
    
    [self.dataArray addObjectsFromArray:bookArr];
    [bookArr release];
    bookArr = nil;
}

#pragma mark -
#pragma mark Accessors

- (UINib *)complexCellNib {
    if (complexCellNib == nil) {
        self.complexCellNib = [GQTMaticDetailCell nib];
    }
    return complexCellNib;
}
@end
