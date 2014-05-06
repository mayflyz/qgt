//
//  GQTMaticDetailViewController.h
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTSelectCource.h"
#import "EGOImageView.h"
#import "ASIHTTPRequest.h"

typedef enum{
    k_jianjie = 0,
    k_bixiu,
    k_xuanxiu
}MaticPageType;

@interface GQTMaticDetailViewController : UIViewController
                                            <
                                            UITableViewDelegate,
                                            UITableViewDataSource,
                                            ASIHTTPRequestDelegate
                                            >
{
    NSMutableArray *dataArray_must;
    NSMutableArray *dataArray_choice;
    MaticPageType pageType;
    NSMutableDictionary *dicInfo;
    GQTSelectCource *selectCource;
}

@property (retain, nonatomic) GQTSelectCource *selectCource;

@property (retain, nonatomic) NSMutableArray *dataArray_must;
@property (retain, nonatomic) NSMutableArray *dataArray_choice;

@property (assign, nonatomic) MaticPageType pageType;
@property (retain, nonatomic) NSMutableDictionary *dicInfo;

@property (retain, nonatomic) IBOutlet UIView *view_title;
@property (retain, nonatomic) IBOutlet EGOImageView *iamge_Title;
@property (retain, nonatomic) IBOutlet UILabel *label_Name;
@property (retain, nonatomic) IBOutlet UILabel *label_tips;
@property (retain, nonatomic) IBOutlet UIButton *btn_jianjie;
@property (retain, nonatomic) IBOutlet UIButton *btn_bixiu;
@property (retain, nonatomic) IBOutlet UIButton *btn_xuanxiu;
@property (retain, nonatomic) IBOutlet UIView *view_main;
@property (retain, nonatomic) IBOutlet UIView *view_jianjie;
@property (retain, nonatomic) IBOutlet UIView *view_bixiu;
@property (retain, nonatomic) IBOutlet UIView *view_xuanxiu;
@property (retain, nonatomic) IBOutlet UILabel *label_type;
@property (retain, nonatomic) IBOutlet UILabel *label_detail;

@property (retain, nonatomic) IBOutlet UITableView *tableView_bixiu;
@property (retain, nonatomic) IBOutlet UITableView *tableView_xuanxiu;
@property (retain, nonatomic) IBOutlet UIScrollView *scroll_jianjie;

@property (nonatomic, retain) UINib *complexCellNib;

- (IBAction)click_jianjie_btn:(id)sender;
- (IBAction)click_xuanxiu_btn:(id)sender;
- (IBAction)click_bixiu_btn:(id)sender;

@end
