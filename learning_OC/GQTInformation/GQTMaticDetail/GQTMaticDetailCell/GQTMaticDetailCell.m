//
//  GQTMaticDetailCell.m
//  learning_OC
//
//  Created by viktyz on 13-3-17.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import "GQTMaticDetailCell.h"

@implementation GQTMaticDetailCell

@synthesize label_title;
@synthesize label_jianjie;
@synthesize label_type;
@synthesize label_zuozhe;
@synthesize image_title;

- (void)dealloc {
    [label_title release];
    [label_zuozhe release];
    [label_jianjie release];
    [image_title release];
    [label_type release];
    [super dealloc];
}
@end
