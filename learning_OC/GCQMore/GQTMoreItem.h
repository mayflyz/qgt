//
//  GQTMoreItem.h
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _MoreItemType {
    MoreItemTypeUserInfo,
    MoreItemTypeLearningCenter,
    MoreItemTypeInfomation,
    MoreItemTypeExamination,
    MoreItemTypeNetWork,
    MoreItemTypeSoftware,
    MoreItemTypeFeedBack,
    MoreItemTypeAbout
}MoreItemType;

@interface GQTMoreItem : NSObject{
    NSString *itemName;
    NSString *imageVersion;
    MoreItemType moreItemType;
}

@property (copy, nonatomic) NSString *itemName;
@property (copy, nonatomic) NSString *imageVersion;
@property (assign, nonatomic) MoreItemType moreItemType;

- (id)initWithItemName:(NSString *)item imageVersion:(NSString *)version moreItemType:(MoreItemType)type;

@end
