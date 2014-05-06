//
//  GQTAreaSelectViewController.h
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"
#import "GQTUserInfo.h"

@protocol GQTAreaSelectDelegate <NSObject>

- (void)areaSelected:(NSDictionary *)valueDic;

@end

@interface GQTAreaSelectViewController : UIViewController<ASIHTTPRequestDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableArray *arrProv;
    NSMutableArray *arrCity;
    NSMutableArray *arrVillage;
    NSMutableArray *arrOrgan;
    
    NSMutableArray *pickerArr;
    id<GQTAreaSelectDelegate> delegate;
    
}

@property (assign, nonatomic) id<GQTAreaSelectDelegate> delegate;
@property (retain, nonatomic) NSMutableArray *pickerArr;
@property (retain, nonatomic) NSMutableArray *arrProv;
@property (retain, nonatomic) NSMutableArray *arrCity;
@property (retain, nonatomic) NSMutableArray *arrVillage;
@property (retain, nonatomic) NSMutableArray *arrOrgan;

@property (retain, nonatomic) IBOutlet UILabel *label_prov;
@property (retain, nonatomic) IBOutlet UILabel *label_city;
@property (retain, nonatomic) IBOutlet UILabel *label_village;
@property (retain, nonatomic) IBOutlet UILabel *label_organ;
@property (retain, nonatomic) IBOutlet UIButton *btn_prov;
@property (retain, nonatomic) IBOutlet UIButton *btn_city;
@property (retain, nonatomic) IBOutlet UIButton *btn_village;
@property (retain, nonatomic) IBOutlet UIButton *btn_organ;

@property (retain, nonatomic) IBOutlet UIView *view_select;
@property (retain, nonatomic) IBOutlet UIPickerView *picker_select;

- (IBAction)btnProvClick:(id)sender;
- (IBAction)btnCityClick:(id)sender;
- (IBAction)btnVillageClick:(id)sender;
- (IBAction)btnOrganClick:(id)sender;
- (IBAction)btnConfirmClick:(id)sender;

- (IBAction)btnAreaSelectClick:(id)sender;
@end
