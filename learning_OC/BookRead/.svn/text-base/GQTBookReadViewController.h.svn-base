//
//  GQTBookReadViewController.h
//  learning_OC
//
//  Created by test on 3/23/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTBookInfo.h"
#import "ASIHTTPRequest.h"

@interface GQTBookReadViewController : UIViewController<ASIHTTPRequestDelegate>{
    GQTBOOKContentInfo *currentContentInfo;
    GQTBookInfo *book;
    GQTBookChapterInfo *currentChapter;
}

@property (retain, nonatomic) GQTBOOKContentInfo *currentContentInfo;
@property (retain, nonatomic) GQTBookInfo *book;
@property (retain, nonatomic) GQTBookChapterInfo *currentChapter;

@property (retain, nonatomic) IBOutlet UILabel *label_Title;
@property (retain, nonatomic) IBOutlet UIScrollView *scollView_Content;
@end
