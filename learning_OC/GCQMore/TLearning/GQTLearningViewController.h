//
//  GQTLearningViewController.h
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

@interface GQTLearningViewController : UIViewController<ASIHTTPRequestDelegate>{
    NSMutableArray *subViewControllers;
    NSInteger selectIndex;
}

@property (retain, nonatomic) IBOutlet UIView *selectView;
@property (retain, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (retain, nonatomic) IBOutlet UIButton *unLearnBtn;
@property (retain, nonatomic) IBOutlet UIButton *progressBtn;
@property (retain, nonatomic) IBOutlet UIButton *complementBtn;

@property (retain, nonatomic) IBOutlet UIButton *courseBtn;
- (IBAction)segmentedSelectClick:(id)sender;
@end
