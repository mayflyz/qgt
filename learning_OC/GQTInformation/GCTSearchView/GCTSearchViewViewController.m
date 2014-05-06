//
//  GCTSearchViewViewController.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GCTSearchViewViewController.h"

#import "GQTSearchTableViewController.h"
#import "ASIFormDataRequest.h"
#import "GQTCommons.h"

@interface GCTSearchViewViewController ()

@end

@implementation GCTSearchViewViewController

@synthesize dataArr;

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
    [self initNavigationBar];
    
    [self.navigationController.navigationBar setBackgroundImage:[GQTCommons getNavigationBarBackImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.search_Text becomeFirstResponder];
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

#pragma mark init

-(void)initNavigationBar
{
    self.navigationItem.title = @"搜索";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *text = searchBar.text;
    
    GQTSearchTableViewController *viewController = [[GQTSearchTableViewController alloc] init];
    viewController.searchKey = text;
    viewController.view.frame = CGRectMake(0, 44, self.scrollView_content.frame.size.width, self.scrollView_content.frame.size.height - 44);
    [self.scrollView_content addSubview:viewController.view];
    
    tableListViewController = viewController;
}


- (void)dealloc {
    [dataArr release];
    [tableListViewController release];
    
    [_table_search release];
    [_search_Text release];
    [_scrollView_content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTable_search:nil];
    [self setSearch_Text:nil];
    [self setScrollView_content:nil];
    [super viewDidUnload];
}
@end
