//
//  GQTFeedbackViewController.h
//  learning_OC
//
//  Created by test on 3/17/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQTFeedbackViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableArray *pickerArr;
    NSInteger selectType;
    NSInteger tag;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_content;

@property (retain, nonatomic) NSMutableArray *pickerArr;

@property (retain, nonatomic) IBOutlet UILabel *laebl_feedType;
@property (retain, nonatomic) IBOutlet UILabel *label_feedContent;

@property (retain, nonatomic) IBOutlet UITextView *text_feedConetn;
@property (retain, nonatomic) IBOutlet UILabel *label_contactWay;
@property (retain, nonatomic) IBOutlet UITextField *field_contactWay;
@property (retain, nonatomic) IBOutlet UIButton *btn_opinios;
@property (retain, nonatomic) IBOutlet UIView *pick_view;
@property (retain, nonatomic) IBOutlet UIPickerView *picker_select;

- (IBAction)opiniosBtnClick:(id)sender;
- (IBAction)pickBtnClick:(id)sender;
@end
