//
//  GQTSearchTableViewController.m
//  learning_OC
//
//  Created by test on 3/24/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTSearchTableViewController.h"
#import "GQTMaticDetailCell.h"
#import "GQTBookInfo.h"
#import "GQTCourseDetailViewController.h"
#import "GQTCommons.h"

#import "AppDelegate.h"

#import "NSObject+SBJson.h"

#import "ASIFormDataRequest.h"

@interface GQTSearchTableViewController ()

- (void)handleJsonStr:(NSString *)jsonStr;

@end

@implementation GQTSearchTableViewController

@synthesize searchKey;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
         self.numberOfDataPerPage = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    NSString *format = [CR_URL_SEARCH stringByAppendingString:@"?page=%d&row=%d"];
    [self setRequestFormat:format requestMoreBy:RequestMoreByPageFromPage];
    
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GQTMaticDetailCell *cell =
    [GQTMaticDetailCell cellForTableView:tableView
                                 fromNib:self.complexCellNib];
    
    GQTBookInfo *book = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.image_title setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [cell.image_title setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:book.bookImage]]];
    
    cell.label_title.text = book.bookName; //@"共青团要做好新形势下的青年群众工作";
    cell.label_zuozhe.text = [NSString stringWithFormat:@"作者： %@",book.bookAuthor]; //@"作者：练月琴";
    
    cell.label_jianjie.text = [NSString stringWithFormat:@"简介：%@", book.bookNote ? book.bookNote : @"暂无简介"];// @"简介：暂无简介";
    cell.label_type.text = @"电子书";
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GQTBookInfo *book = [self.dataArray objectAtIndex:indexPath.row];
    
    GQTCourseDetailViewController *detail_ = [[GQTCourseDetailViewController alloc] initWithNibName:@"GQTCourseDetailViewController" bundle:nil];
    detail_.bookInfo = book;
    detail_.hidesBottomBarWhenPushed = YES;
    
    [[APP_DELEGATE selectedNavigationController] pushViewController:detail_ animated:YES];
    [detail_ release];

}

#pragma mark -
#pragma mark RefreshTableView
- (ASIHTTPRequest *)requestForMoreData:(BOOL)reload{
    ASIHTTPRequest *request = [super requestForMoreData:reload];
    ASIFormDataRequest *formDataRequest = [ASIFormDataRequest requestWithURL:request.url];
    
    if (searchKey != nil) {
        [formDataRequest setPostValue:searchKey forKey:@"str"];
    }
    
    formDataRequest.delegate = self;
    formDataRequest.tag = request.tag;
    return formDataRequest;
}

- (void)loadDataRequestSuccess:(ASIHTTPRequest *)request{
    NSString *string=[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    
    [self handleJsonStr:string];
}

#pragma mark - handle json str parse
- (void)handleJsonStr:(NSString *)jsonStr{
    NSMutableDictionary *valueDic = [jsonStr JSONValue];
    
    NSInteger status = [[valueDic objectForKey:@"state"] integerValue];
    //    NSInteger recordCount = [[valueDic objectForKey:@"recordCount"] integerValue];
    //    NSInteger row = [[valueDic objectForKey:@"row"] integerValue];  //当前总页数
    NSMutableArray *bookArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (status == 200) {
        NSArray *list = [valueDic objectForKey:@"booklist"];
        
        for (NSDictionary *temp in list) {
            GQTBookInfo *book = [[GQTBookInfo alloc] init];
            book.bookId = [[temp objectForKey:@"bookId"] integerValue];
            book.bookName = [temp objectForKey:@"bookName"];
            book.bookImage = [temp objectForKey:@"bookCover"];
            book.bookAuthor = [temp objectForKey:@"bookAuthor"];
            book.bookNote = [temp objectForKey:@"bookNote"];
            
            book.categoryId = [[temp objectForKey:@"categoryId"] integerValue];
            book.categoryName = [temp objectForKey:@"categoryName"];
            book.categoryCode = [temp objectForKey:@"categoryCode"];
            book.type = CourseTypeBook;
            
            [bookArr addObject:book];
            [book release];
        }
    }
    
    [self.dataArray addObjectsFromArray:bookArr];
    [bookArr release];
    bookArr = Nil;
}

#pragma mark -
#pragma mark Accessors

- (UINib *)complexCellNib {
    if (_complexCellNib == nil) {
        self.complexCellNib = [GQTMaticDetailCell nib];
    }
    return _complexCellNib;
}


@end
