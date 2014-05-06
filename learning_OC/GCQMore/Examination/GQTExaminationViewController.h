//
//  GQTExaminationViewController.h
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQTExamTableViewController.h"

#import "ASIHTTPRequest.h"
@interface GQTExaminationViewController : UIViewController<ASIHTTPRequestDelegate>{
    
    NSMutableArray *subViewControllers;
    NSInteger selectIndex;
    GQTExamTableViewController *tableViewController;
}

@property (retain, nonatomic) GQTExamTableViewController *tableViewController;
@property (retain, nonatomic) IBOutlet UIButton *complementBtn;
@property (retain, nonatomic) IBOutlet UIButton *unComplementBtn;
@property (retain, nonatomic) IBOutlet UIScrollView *examContentScrollView;
@property (retain, nonatomic) IBOutlet UIView *view_main;

- (IBAction)examinationSelect:(id)sender;

@end
