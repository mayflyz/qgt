//
//  GQTLoginViewController.h
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface GQTLoginViewController : UIViewController<ASIHTTPRequestDelegate,UITextFieldDelegate>{
    
}

@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;

@property (retain, nonatomic) IBOutlet UIView *view_loginContent;
@property (retain, nonatomic) IBOutlet UIButton *loginBtn;
@property (retain, nonatomic) IBOutlet UIButton *getNewAccount;

@property (retain, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (retain, nonatomic) IBOutlet UIImageView *loginNameImageView;
@property (retain, nonatomic) IBOutlet UITextField *loginName;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UIScrollView *scroll_content;

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)getNewAccountClick:(id)sender;
@end
