//
//  GQTExamInfo.m
//  learning_OC
//
//  Created by test on 3/20/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTExamInfo.h"

@implementation GQTExamInfo

@synthesize examImage;
@synthesize examName;
@synthesize examScroe;

- (id)initWithName:(NSString *)name examImage:(NSString *)image examScroe:(NSString *)scroe{
    if (self = [super init]) {
        examName = name;
        examImage = image;
        examScroe = scroe;
    }
    
    return self;
}

- (void)dealloc{
    [examScroe release];
    [examName release];
    [examScroe release];
    
    [super dealloc];
}

@end

@implementation GQTCategoryInfo

@synthesize categoryId;
@synthesize categoryCode;
@synthesize categoryName;
@synthesize categoryType;
@synthesize hasNext;

- (void)dealloc{
    [categoryName release];
    [categoryCode release];
    
    [super dealloc];
}

@end