//
//  GQTBookInfo.m
//  learning_OC
//
//  Created by test on 3/20/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTBookInfo.h"

@implementation GQTBookInfo

@synthesize bookId;
@synthesize bookAuthor;
@synthesize bookImage;
@synthesize bookName;
@synthesize bookNote;

@synthesize categoryId;
@synthesize categoryCode;
@synthesize categoryName;

@synthesize teacherId;
@synthesize teacherName;
@synthesize type;

-(void)dealloc{
    [bookName release];
    [bookAuthor release];
    [bookImage release];
    [bookNote release];
    
    [categoryName release];
    [categoryCode release];
    
    [teacherName release];
    
    [super dealloc];
}

@end

@implementation GQTBOOKContentInfo

@synthesize bookId;
@synthesize bookAuthor;
@synthesize bookName;

@synthesize contentId;
@synthesize contentPage;
@synthesize contentTitle;
@synthesize content;

@synthesize type;

- (void)dealloc{
    [bookAuthor release];
    [bookName release];
    [contentTitle release];
    [content release];
    
    [super dealloc];
}

@end


@implementation GQTBookChapterInfo

@synthesize chapterId;
@synthesize chapterPageNumber;
@synthesize chapterTitle;

- (void)dealloc{
    [chapterTitle release];
    
    [super dealloc];
}

@end

@implementation GQTVideoChapterInfo

@synthesize videoChapterId;
@synthesize videoTeacherName;
@synthesize videoTime;
@synthesize videoName;

@synthesize videoUrl;
@synthesize videoTeacherId;

- (void)dealloc{
    [videoTeacherName release];
    [videoUrl release];
    [videoName release];
    
    [super dealloc];
}

@end