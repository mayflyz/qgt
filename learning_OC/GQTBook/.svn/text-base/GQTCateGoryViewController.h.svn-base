//
//  GQTCateGoryViewController.h
//  learning_OC
//
//  Created by test on 3/23/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTExamInfo.h"

@protocol GQTCategorySelectDelegate <NSObject>

- (void)categorySelect:(GQTCategoryInfo *)info;

@end

@interface GQTCateGoryViewController : UIViewController{
    NSArray *categoryArr;
    BOOL sigleLineShow;
    id<GQTCategorySelectDelegate> delegate;
}

@property (assign, nonatomic) id<GQTCategorySelectDelegate> delegate;
@property (retain, nonatomic) NSArray *categoryArr;
@property (assign, nonatomic) BOOL sigleLineShow;

- (void)initCategoryPistion;
- (IBAction)categoryButtonClick:(id)sender;

+ (CGFloat)heightOfCategoryCount:(NSInteger)count isTopCategory:(BOOL)flag;

@end
