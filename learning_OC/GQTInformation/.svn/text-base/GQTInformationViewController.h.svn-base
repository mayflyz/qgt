//
//  GQTInformationViewController.h
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTSearchViewViewController.h"
#import "GQTMaticDetailViewController.h"
#import "ASIHTTPRequest.h"

@interface GQTInformationViewController : UIViewController
<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate,
ASIHTTPRequestDelegate
>
{
    NSMutableArray *arrTitles;
    GQTMaticDetailViewController *MaticDetailPage;
    
    NSArray *dataArray;
    NSArray *bigImageArray;
}

@property (retain, nonatomic)  NSArray *dataArray;
@property (retain, nonatomic)  NSArray *bigImageArray;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_Title;
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UITableView *tableView_Info;
@property (retain, nonatomic) NSMutableArray *arrTitles;
@property (retain, nonatomic) GQTMaticDetailViewController *MaticDetailPage;

@property (nonatomic, retain) UINib *complexCellNib;

@end
