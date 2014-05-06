//
//  GQTCouserBaseInfo.m
//  learning_OC
//
//  Created by test on 3/20/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTCouserBaseInfo.h"

@implementation GQTCouserBaseInfo

@synthesize courseId;
@synthesize courseName;
@synthesize courseImage;
@synthesize courseNote;

- (id)initWithId:(NSInteger)id courseName:(NSString *)name courseImage:(NSString *)image courseNote:(NSString *)note{
    if (self = [super init]) {
        courseId = id;
        courseName = name;
        courseImage = image;
        courseNote = note;
    }
    
    return self;
}

- (void)dealloc{
    [courseName release];
    [courseNote release];
    [courseImage release];
    
    [super dealloc];
}


@end


@implementation ImageInfo

@synthesize imageId;
@synthesize imageTitle;
@synthesize imageUrl;
@synthesize linkURL;
@synthesize targetId;
@synthesize type;
@synthesize note;

- (void)dealloc{
    [imageTitle release];
    [imageUrl release];
    [imageUrl release];
    [targetId release];
    [type release];
    [note release];
    
    [super dealloc];
}

@end



@implementation NoticeInfo

@synthesize noticeid;
@synthesize noticeeditor;
@synthesize noticeimage;
@synthesize noticetitle;
@synthesize createTime;

- (void)dealloc{
    [noticetitle release];
    [noticeeditor release];
    [noticeimage release];
    [createTime release];
    
    [super dealloc];
}

@end


@implementation NoticeInfoContent

@synthesize noticeContent;
@synthesize noticeSource;
@synthesize noticeSummary;
@synthesize noticeExpiretime;


- (void)dealloc{
    [noticeContent release];
    [noticeSummary release];
    [noticeExpiretime release];
    [noticeSource release];
    
    [super dealloc];
}

@end