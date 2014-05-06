//
//  GCQMoreViewController.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GCQMoreViewController.h"

#import "GQTMoreItem.h"

#import "GQTLearningViewController.h"
#import "GQTInfomationViewController.h"
#import "GQTExaminationViewController.h"
#import "GQTNetWorkViewController.h"
#import "GQTSoftwareViewController.h"
#import "GQTFeedbackViewController.h"
#import "GQTAboutViewController.h"

#import "GQTCommons.h"
#import "AppDelegate.h"
#import "UITools.h"

#import "GQTLoginViewController.h"
#import "GQTUserInfoViewController.h"

#define TinMessage @"未登录，请先登陆" 

@interface GCQMoreViewController (){
}

@end

@implementation GCQMoreViewController

@synthesize dataArray;
@synthesize tableViewCell = _tableViewCell;
@synthesize itemsTableView = _itemsTableView;


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
    
    [self initNavigationBar];
    
    [GQTCommons setViewBackImage:self.view];
    [self initMoreList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [dataArray release];
    
    [_tableViewCell release];
    [_itemsTableView release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setItemsTableView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

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

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataArray objectAtIndex:section] count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 57;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MoreIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"GCQMoreViewCell" owner:self options:nil];
        cell = self.tableViewCell;
        self.tableViewCell = nil;
    }
    
    GQTMoreItem *item = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UIButton *imageButton = (UIButton *)[cell viewWithTag:31701];
    
    UIImage *titleImage = nil;
    UIImageView *tailImage = (UIImageView *)[cell viewWithTag:31703];
    
    switch (item.moreItemType) {
        case MoreItemTypeUserInfo:{
            [tailImage setHidden:YES];
            titleImage = [UIImage imageNamed:@"ico_user.png"];
        }
            break;
        case MoreItemTypeLearningCenter:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            titleImage =  [UIImage imageNamed:@"ico_user.png"];
        }
            break;
        case MoreItemTypeInfomation:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            titleImage = [UIImage imageNamed:@"ico_announcement.png"];
        }
            break;
        case MoreItemTypeExamination:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            titleImage = [UIImage imageNamed:@"ico_examination.png"];
        }
            break;
        case MoreItemTypeNetWork:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            titleImage = [UIImage imageNamed:@"ico_network.png"];
        }
            break;
        case MoreItemTypeSoftware:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            titleImage = [UIImage imageNamed:@"ico_software.png"];
        }
            break;
        case MoreItemTypeFeedBack:{
            [tailImage setHidden:YES];
            titleImage = [UIImage imageNamed:@"ico_feedback.png"];
        }
            break;
        case MoreItemTypeAbout:{
            [tailImage setHidden:YES];
            titleImage = [UIImage imageNamed:@"ico_about.png"];
        }
            break;
            
        default:
            break;
    }
    
    [imageButton setImage:titleImage forState:UIControlStateDisabled];
    [imageButton setEnabled:NO];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:31702];
    [titleLabel setText:item.itemName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
      GQTMoreItem *item = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    switch (item.moreItemType) {
        case MoreItemTypeUserInfo:{
            
            if (!APP_DELEGATE.userInfo) {
                [self showAlertView:MoreItemTypeUserInfo];
                return ;
            }
            
            GQTUserInfoViewController *viewController = [[GQTUserInfoViewController alloc] init];
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
            
            }
            break;
        case MoreItemTypeLearningCenter:{
            if (!APP_DELEGATE.userInfo) {
                [self showAlertView:MoreItemTypeLearningCenter];
                return ;
            }
            
            GQTLearningViewController *learingViewController = [[GQTLearningViewController alloc] initWithNibName:@"GQTLearningViewController" bundle:nil];
            
            learingViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:learingViewController animated:YES];
            [learingViewController release];
            
            }
            break;
        case MoreItemTypeInfomation:{
            if (!APP_DELEGATE.userInfo) {
                [self showAlertView:MoreItemTypeInfomation];
                return ;
            }
            
            GQTInfomationViewController *infomationViewController = [[GQTInfomationViewController alloc] initWithNibName:@"GQTInfomationViewController" bundle:nil];
            infomationViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:infomationViewController animated:YES];
            [infomationViewController release];
            
            }
            break;
        case MoreItemTypeExamination:{
            if (!APP_DELEGATE.userInfo) {
                [self showAlertView:MoreItemTypeExamination];
                return ;
            }
            GQTExaminationViewController *examinationViewController = [[GQTExaminationViewController alloc] initWithNibName:@"GQTExaminationViewController" bundle:nil];
            examinationViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:examinationViewController animated:YES];
            [examinationViewController release];
            
            }
            break;
        case MoreItemTypeNetWork:{
            GQTNetWorkViewController *netWorkViewController = [[GQTNetWorkViewController alloc] initWithNibName:@"GQTNetWorkViewController" bundle:nil];
            netWorkViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:netWorkViewController animated:YES];
            [netWorkViewController release];
            
            }
            break;
        case MoreItemTypeSoftware:{
            GQTSoftwareViewController *softwareViewController = [[GQTSoftwareViewController alloc] initWithNibName:@"GQTSoftwareViewController" bundle:nil];
            softwareViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:softwareViewController animated:YES];
            [softwareViewController release];
            
            }
            break;
        case MoreItemTypeFeedBack:{
            
            GQTFeedbackViewController *feedbackViewController = [[GQTFeedbackViewController alloc] initWithNibName:@"GQTFeedbackViewController" bundle:nil];
            feedbackViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feedbackViewController animated:YES];
            [feedbackViewController release];
            
            }
            break;
        case MoreItemTypeAbout:{
            
            GQTAboutViewController *aboutViewController = [[GQTAboutViewController alloc] initWithNibName:@"GQTAboutViewController" bundle:nil];
            aboutViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutViewController animated:YES];
            [aboutViewController release];
            
            }
            break;
            
        default:
            break;
    }
    
}


-(void)initNavigationBar
{
    self.navigationItem.title = @"更多";
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)initMoreList{
    
    GQTMoreItem *item0 = [[GQTMoreItem alloc] initWithItemName:@"个人信息" imageVersion:nil moreItemType:MoreItemTypeUserInfo];
    
    GQTMoreItem *item1 = [[GQTMoreItem alloc] initWithItemName:@"学习中心" imageVersion:nil moreItemType:MoreItemTypeLearningCenter];
     GQTMoreItem *item2 = [[GQTMoreItem alloc] initWithItemName:@"公告资讯" imageVersion:nil moreItemType:MoreItemTypeInfomation];
     GQTMoreItem *item3 = [[GQTMoreItem alloc] initWithItemName:@"考试查询" imageVersion:nil moreItemType:MoreItemTypeExamination];
//     GQTMoreItem *item4 = [[GQTMoreItem alloc] initWithItemName:@"网络分校" imageVersion:nil moreItemType:MoreItemTypeNetWork];
//    GQTMoreItem *item5 = [[GQTMoreItem alloc] initWithItemName:@"精品软件" imageVersion:nil moreItemType:MoreItemTypeSoftware];
//    GQTMoreItem *item6 = [[GQTMoreItem alloc] initWithItemName:@"在线反馈" imageVersion:nil moreItemType:MoreItemTypeFeedBack];
    GQTMoreItem *item7 = [[GQTMoreItem alloc] initWithItemName:@"关于" imageVersion:nil moreItemType:MoreItemTypeAbout];
    
    NSArray *newArray = [NSArray arrayWithObjects:item1,item2,item3, nil];
    [item1 release];
    [item2 release];
    [item3 release];
//    [item4 release];
//    [item5 release];
    
    NSArray *feedArray = [NSArray arrayWithObjects:item7, nil];
    
//    [item6 release];
    [item7 release];
    
    NSArray *array = [[NSArray alloc] initWithObjects:[NSArray arrayWithObject:item0],newArray,feedArray,nil];
    self.dataArray = array;
    [item0 release];
    [array release];
}


- (void)showAlertView:(int)tag{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"友情提示：" message:TinMessage  delegate:self cancelButtonTitle:@"等会" otherButtonTitles:@"确定",nil ];
    alert.tag = tag;
    [alert show];
    [alert release];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        GQTLoginViewController *viewController = [[GQTLoginViewController alloc] init];
        viewController.hidesBottomBarWhenPushed = YES;
//        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    }
}
@end

