//
//  GQTMaticDetailCell.h
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PRPNibBasedTableViewCell.h"
#import "EGOImageView.h"

@interface GQTMaticDetailCell : PRPNibBasedTableViewCell{}

@property (retain, nonatomic) IBOutlet UILabel *label_title;
@property (retain, nonatomic) IBOutlet UILabel *label_zuozhe;
@property (retain, nonatomic) IBOutlet UILabel *label_jianjie;
@property (retain, nonatomic) IBOutlet EGOImageView *image_title;
@property (retain, nonatomic) IBOutlet UILabel *label_type;
@end
