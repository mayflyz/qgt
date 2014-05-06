//
//  GQTInfomationTableViewController.m
//  learning_OC
//
//  Created by test on 3/19/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTInfomationTableViewController.h"

#import "EGOImageView.h"
#import "NSObject+SBJson.h"
#import "GQTCouserBaseInfo.h"
#import "GQTCommons.h"
#import "AppDelegate.h"

#import "GQTInfoContenViewController.h"

#define InfomationCellHeight 80

@interface GQTInfomationTableViewController ()

@end

@implementation GQTInfomationTableViewController

@synthesize type;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        type = InfomationTypeNew;
    }
    return self;
}

- (void)viewDidLoad
{
    if (type == InfomationTypeNew) {        //资讯
        
        NSString *formate = [CR_URL_NEW stringByAppendingString:@"?page=%d&row=%d"];
        [self setRequestFormat:formate requestMoreBy:RequestMoreByPageFromPage];
        
    }else if (type == InfomationTypeInfo){      //公告
        
        NSString *format = [CR_URL_NOTICE stringByAppendingString:@"?page=%d&row=%d"];
        [self setRequestFormat:format requestMoreBy:RequestMoreByPageFromPage];
        
    }
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"GQTInfomationCell" owner:self options:nil];
        cell = self.infomationCell;
        self.infomationCell = nil;
    }
    
    NoticeInfo *info = [self.dataArray objectAtIndex:indexPath.row];
    
    EGOImageView *learningImage = (EGOImageView *)[cell viewWithTag:2013031801];
    [learningImage setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [learningImage setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:info.noticeimage]]];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:2013031802];
    [titleLabel setText:info.noticetitle];
    
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:2013031803];
    [contentLabel setText:[NSString stringWithFormat:@"作者:%@",info.noticeeditor]];
    
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:2013031804];
    [timeLabel setText:[NSString stringWithFormat:@"发表于:%@",info.createTime]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return InfomationCellHeight;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NoticeInfo *info = [self.dataArray objectAtIndex:indexPath.row];
    GQTInfoContenViewController *viewController = [[GQTInfoContenViewController alloc] init];
    viewController.noticeId = info.noticeid;
    viewController.hidesBottomBarWhenPushed = YES;
    [[APP_DELEGATE selectedNavigationController] pushViewController:viewController animated:YES];
    [viewController release];
}

- (void)loadDataRequestSuccess:(ASIHTTPRequest *)request{
    NSString *string=[[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
   
    [self handleInfoJsonStr:string];

}

- (void)handleInfoJsonStr:(NSString *)jsonStr{
    NSMutableDictionary *valueDic = [jsonStr JSONValue];
    
    NSInteger state = [[valueDic objectForKey:@"state"] integerValue];
    if (state == 200) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
        
//        NSInteger page = [[valueDic objectForKey:@"page"] integerValue];
//        NSInteger totalpage = [[valueDic objectForKey:@"totalpage"] integerValue];
//        NSInteger size = [[valueDic objectForKey:@"size"] integerValue];
        
        NSArray *contentList = [valueDic objectForKey:@"contentlist"];
        for (NSDictionary *temp in contentList) {
            NoticeInfo *info = [[NoticeInfo alloc] init];
            info.noticeid = [[temp objectForKey:@"contentid"] integerValue];
            info.noticetitle = [temp objectForKey:@"contenttitle"];
            info.noticeeditor = [temp objectForKey:@"contenteditor"];
            info.noticeimage = [temp objectForKey:@"contentimage"];
            info.createTime = [temp objectForKey:@"createtime"];
            [tempArr addObject:info];
            [info release];
        }
        [self.dataArray addObjectsFromArray:tempArr];
        [tempArr release];
    }
}

- (void)dealloc {
    
    [_infomationCell release];
    [super dealloc];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}
@end
