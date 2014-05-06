//
//  GQTLearingTableViewController.m
//  learning_OC
//
//  Created by test on 3/18/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTLearingTableViewController.h"

#import "GQTMaticDetailViewController.h"

#import "EGOImageView.h"
#import "ASIHTTPRequest.h"
#import "GQTSelectCource.h"
#import "GQTCommons.h"

#import "AppDelegate.h"

#define LearningHeight 80

@interface GQTLearingTableViewController ()

@end

@implementation GQTLearingTableViewController

@synthesize dataArray;
@synthesize type;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //处理网络请求
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
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"GQTLearningCell" owner:self options:nil];
        cell = self.learningCell;
        self.learningCell = nil;
    }
    
    GQTSelectCource *select = [self.dataArray objectAtIndex:indexPath.row];
    
    EGOImageView *learningImage = (EGOImageView *)[cell viewWithTag:2013031801];
    [learningImage setPlaceholderImage:[UIImage imageNamed:@"ico_nophoto.png"]];
    [learningImage setImageURL:[NSURL URLWithString:[GQTCommons getImageUrl:select.taskimage]]];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:2013031802];
    [titleLabel setText:select.taskname];
    
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:2013031803];
    [contentLabel setText:select.tasknote];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LearningHeight;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GQTSelectCource *select = [self.dataArray objectAtIndex:indexPath.row];
    GQTMaticDetailViewController *viewController = [[GQTMaticDetailViewController alloc] init];
    viewController.selectCource = select;
    viewController.hidesBottomBarWhenPushed = YES;
    [[APP_DELEGATE selectedNavigationController] pushViewController:viewController animated:YES];
    viewController.navigationItem.rightBarButtonItem.title = @"返回";
    [viewController release];
}

- (void)dealloc {
    [dataArray release];
    
    [_learningCell release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setLearningCell:nil];
    [super viewDidUnload];
}
@end
