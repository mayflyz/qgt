//
//  GQTTypeSelectViewController.h
//  learning_OC
//
//  Created by test on 4/29/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"
#import "GQTUserInfo.h"

@protocol GQTTypeSelectDelegate <NSObject>

- (void)typeSelect:(GQTypeInfo *)typInfo;

@end

@interface GQTTypeSelectViewController : UIViewController<ASIHTTPRequestDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    int selectTag;
    NSMutableArray *m_pickerArr;
    NSMutableArray *m_firstArr;
    NSMutableArray *m_secondArr;
    id<GQTTypeSelectDelegate> delegate;
}

@property (assign, nonatomic) id<GQTTypeSelectDelegate> delegate;
@property (retain, nonatomic) NSMutableArray *m_pickerArr;
@property (retain, nonatomic) NSMutableArray *m_firstArr;
@property (retain, nonatomic) NSMutableArray *m_secondArr;

@property (retain, nonatomic) IBOutlet UILabel *m_typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *m_typeSecLabel;

@property (retain, nonatomic) IBOutlet UIView *view_select;

@property (retain, nonatomic) IBOutlet UIPickerView *picker_select;
@property (retain, nonatomic) IBOutlet UIButton *m_typeSelectOneBtn;
@property (retain, nonatomic) IBOutlet UIButton *m_typeSelectSecBtn;

- (IBAction)click_confirmTypeSelect:(id)sender;
- (IBAction)clickTypeSelectConfirmBtn:(id)sender;

- (IBAction)clickSelectTypeBtn:(id)sender;
- (IBAction)clickNextSelectBtn:(id)sender;
@end
