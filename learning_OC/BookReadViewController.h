//
//  BookReadViewController.h
//  learning_OC
//
//  Created by test on 3/23/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GQTBookInfo.h"
#import "ASIHTTPRequest.h"

typedef enum {
    PageTypePre,
    PageTypeCur,
    PageTypeNext
}PageType;

@interface BookReadViewController : UIViewController<ASIHTTPRequestDelegate,UIScrollViewDelegate>{
    GQTBookInfo *book;
    
    PageType type;
    
    GQTBOOKContentInfo *currentContentInfo;
    
    GQTBookChapterInfo *currentChapter;
    
    NSArray *chapterArr;
    
    
    NSMutableArray *subviewsArray;
    PageType willshowType;
}


@property (retain, nonatomic) GQTBookInfo *book;

@property (retain, nonatomic) GQTBOOKContentInfo *currentContentInfo;

@property (retain, nonatomic) NSMutableArray *subviewsArray;
@property (retain, nonatomic) NSArray *chapterArr;

@property (retain, nonatomic) GQTBookChapterInfo *currentChapter;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView_Content;

@end
