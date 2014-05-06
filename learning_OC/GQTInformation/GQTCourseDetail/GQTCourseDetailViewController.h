//
//  GQTCourseDetailViewController.h
//  learning_OC
//
//  Created by viktyz on 13-3-18.
//  Copyright (c) 2013年 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTBookInfo.h"
#import "EGOImageView.h"
#import "GQTBookChapterListViewController.h"

typedef enum{
    k_Course_jianjie = 0,
    k_Course_keshi
}CoursePageType;

@interface GQTCourseDetailViewController : UIViewController
{
    CoursePageType PageType;
    NSMutableDictionary *dicInfo;
    GQTBookInfo *bookInfo;
    GQTBookChapterListViewController *bookChapterList;
}

@property (retain, nonatomic) GQTBookChapterListViewController *bookChapterList;
@property (retain, nonatomic) GQTBookInfo *bookInfo;

@property (assign, nonatomic) CoursePageType PageType;
@property (retain, nonatomic) NSMutableDictionary *dicInfo;
@property (retain, nonatomic) IBOutlet UIView *view_main;
@property (retain, nonatomic) IBOutlet EGOImageView *image_title;
@property (retain, nonatomic) IBOutlet UIButton *btn_jianjie;
@property (retain, nonatomic) IBOutlet UIButton *btn_keshi;
@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UIView *view_jianjie;
@property (retain, nonatomic) IBOutlet UIView *view_keshi;
@property (retain, nonatomic) IBOutlet UILabel *label_zuozhe;
@property (retain, nonatomic) IBOutlet UILabel *label_leixing;
@property (retain, nonatomic) IBOutlet UILabel *label_jianjie;

- (IBAction)click_jianjie_btn:(id)sender;
- (IBAction)click_keshi_btn:(id)sender;
@end
