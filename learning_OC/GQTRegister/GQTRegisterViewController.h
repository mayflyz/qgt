//
//  GQTRegisterViewController.h
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "GQTAreaSelectViewController.h"

#import "GQTTypeSelectViewController.h"

@interface GQTRegisterViewController : UIViewController<ASIHTTPRequestDelegate,UITextFieldDelegate,GQTAreaSelectDelegate,GQTTypeSelectDelegate>{
    UIView *currentView;
    NSDictionary *groupInfo;
    GQTypeInfo *typeInfo;
}

@property (retain, nonatomic)   GQTypeInfo *typeInfo;
@property (retain, nonatomic)   NSDictionary *groupInfo;
@property (retain, nonatomic)   UIView *currentView;

@property (retain, nonatomic) IBOutlet UIScrollView *scroll_content;

@property (retain, nonatomic) IBOutlet UIImageView *accountImageView;
@property (retain, nonatomic) IBOutlet UIImageView *nikeImageView;
@property (retain, nonatomic) IBOutlet UIImageView *phoneImageView;
@property (retain, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (retain, nonatomic) IBOutlet UIImageView *confirmPassword;

@property (retain, nonatomic) IBOutlet UITextField *text_account;
@property (retain, nonatomic) IBOutlet UITextField *text_phoneNumber;
@property (retain, nonatomic) IBOutlet UITextField *text_nike;
@property (retain, nonatomic) IBOutlet UITextField *text_password;
@property (retain, nonatomic) IBOutlet UITextField *text_confirmPassword;
@property (retain, nonatomic) IBOutlet UIButton *areaSelectBtn;
- (IBAction)typeSelectBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *typeSelectBtn;
@property (retain, nonatomic) IBOutlet UILabel *label_area;
@property (retain, nonatomic) IBOutlet UILabel *label_typeInfo;

@property (retain, nonatomic) IBOutlet UIImageView *backimageView;
@property (retain, nonatomic) IBOutlet UIImageView *backImage1;
@property (retain, nonatomic) IBOutlet UIImageView *backImage2;
@property (retain, nonatomic) IBOutlet UIImageView *backImage3;
@property (retain, nonatomic) IBOutlet UIImageView *backImage4;
@property (retain, nonatomic) IBOutlet UIImageView *backImage5;
@property (retain, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)registerBtnClick:(id)sender;
- (IBAction)areaSelectClick:(id)sender;
- (IBAction)typeSelectClick:(id)sender;
@end
