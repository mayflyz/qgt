//
//  GQTExamInfo.h
//  learning_OC
//
//  Created by test on 3/20/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQTExamInfo : NSObject {
    NSString  *examName;
    NSString  *examScroe;
    NSString  *examImage;
}

@property (copy, nonatomic) NSString    *examName;
@property (copy, nonatomic) NSString    *examScroe;
@property (copy, nonatomic) NSString    *examImage;

@end


@interface GQTCategoryInfo : NSObject{
    NSInteger  categoryId;
    NSString  *categoryName;
    NSString  *categoryType;
    NSString  *categoryCode;
    BOOL hasNext;
}

@property (assign, nonatomic) NSInteger  categoryId;
@property (retain, nonatomic) NSString  *categoryName;
@property (assign, nonatomic) NSString  *categoryType;
@property (retain, nonatomic) NSString  *categoryCode;
@property (assign, nonatomic) BOOL hasNext;

@end

