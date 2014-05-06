//
//  GQTCateGoryViewController.m
//  learning_OC
//
//  Created by test on 3/23/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTCateGoryViewController.h"
#import "GQTExamInfo.h"
#import <QuartzCore/QuartzCore.h>

#define UI_Button_Height 30

@interface GQTCateGoryViewController ()

@end

@implementation GQTCateGoryViewController

@synthesize categoryArr;
@synthesize delegate;
@synthesize sigleLineShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc{
    delegate = nil;
    [categoryArr release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categoryButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    GQTCategoryInfo *category = [self.categoryArr objectAtIndex:button.tag];
    
    if (delegate && [delegate respondsToSelector:@selector(categorySelect:)]) {
        [delegate categorySelect:category];
    }
}

- (void)initCategoryPistion{
    if (sigleLineShow) {
        
        for (int i = 0; i <[self.categoryArr count]; i++) {
            GQTCategoryInfo *categoryInfo = [self.categoryArr objectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, i*UI_Button_Height, self.view.frame.size.width, UI_Button_Height);
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 0.3;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;

            button.backgroundColor = [UIColor clearColor];
            
            button.tag = i;
            [button setTitle:categoryInfo.categoryName forState:UIControlStateNormal];
            [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
        
    }else{
        for (int i = 0; i < [self.categoryArr count]; i++) {
            GQTCategoryInfo *cateGoryInfo = [self.categoryArr objectAtIndex:i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setFrame:CGRectMake(i%2 * self.view.frame.size.width /2, (i/2)*UI_Button_Height, self.view.frame.size.width/2, UI_Button_Height)];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 0.3;
            button.layer.borderWidth = 0.5;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            
     
            button.backgroundColor = [UIColor clearColor];
            
            button.tag = i;
            [button setTitle:cateGoryInfo.categoryName forState:UIControlStateNormal];
            [button addTarget:self action:@selector(categoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
}

+ (CGFloat)heightOfCategoryCount:(NSInteger)count isTopCategory:(BOOL)flag{
    CGFloat height = 0;
    if (flag) {         //顶级分类，一行显示两个
        height = (count/2 + count%2)*UI_Button_Height;
    }else{
        height = count * UI_Button_Height;
    }
    
    return height;
}

@end
