//
//  GQTSearchTableViewController.h
//  learning_OC
//
//  Created by test on 3/24/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableViewController.h"

@interface GQTSearchTableViewController : EGORefreshTableViewController{
    NSString *searchKey;
}

@property (retain, nonatomic) NSString *searchKey;

@property (nonatomic, retain) UINib *complexCellNib;
@end
