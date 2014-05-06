//
//  BookShowViewController.h
//  learning_OC
//
//  Created by test on 4/1/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTBookInfo.h"

@interface BookShowViewController : UIViewController{
    GQTBOOKContentInfo *currentContentInfo;
    
    GQTBookChapterInfo *currentChapter;
}

@property (retain, nonatomic) GQTBOOKContentInfo *currentContentInfo;
@property (retain, nonatomic) GQTBookChapterInfo *currentChapter;

@property (retain, nonatomic) IBOutlet UILabel *label_title;
@property (retain, nonatomic) IBOutlet UIScrollView *Scroll_Content;

@end
