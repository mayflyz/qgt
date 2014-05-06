//
//  GCQMoreViewController.h
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCQMoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIAlertViewDelegate>{
    NSArray *dataArray;
}


@property (retain, nonatomic) NSArray *dataArray;


@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;

@property (retain, nonatomic) IBOutlet UITableView *itemsTableView;

@end
