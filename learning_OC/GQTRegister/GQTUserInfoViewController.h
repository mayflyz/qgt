//
//  GQTUserInfoViewController.h
//  learning_OC
//
//  Created by test on 4/12/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQTUserInfoViewController : UIViewController<UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *backImageView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_content;

@property (retain, nonatomic) IBOutlet UILabel *label_userName;
@property (retain, nonatomic) IBOutlet UILabel *label_nikeName;
@property (retain, nonatomic) IBOutlet UILabel *label_email;
@property (retain, nonatomic) IBOutlet UILabel *label_phone;
@property (retain, nonatomic) IBOutlet UILabel *label_area;
@end
