//
//  GQTInfomationTableViewController.h
//  learning_OC
//
//  Created by test on 3/19/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableViewController.h"

typedef enum _InfomationType{
    InfomationTypeNew,
    InfomationTypeInfo
}InfomationType;

@interface GQTInfomationTableViewController : EGORefreshTableViewController{
    InfomationType type;
}

@property (assign, nonatomic) InfomationType type;

@property (retain, nonatomic) IBOutlet UITableViewCell *infomationCell;

@end
