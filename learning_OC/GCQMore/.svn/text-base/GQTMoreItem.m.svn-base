//
//  GQTMoreItem.m
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTMoreItem.h"

@implementation GQTMoreItem

@synthesize itemName;
@synthesize imageVersion;
@synthesize moreItemType;

- (id)init{
    if (self = [super init]) {
        moreItemType = MoreItemTypeUserInfo;
    }
    
    return self;
}

- (id)initWithItemName:(NSString *)item imageVersion:(NSString *)version moreItemType:(MoreItemType)type{
    if (self = [super init]) {
        itemName = item;
        imageVersion = version;
        moreItemType = type;
    }
    
    return self;
}

- (void)dealloc{
    [imageVersion release];
    [itemName release];
    
    [super dealloc];
}

@end
