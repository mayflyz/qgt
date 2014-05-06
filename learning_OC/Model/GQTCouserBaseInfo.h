//
//  GQTCouserBaseInfo.h
//  learning_OC
//
//  Created by test on 3/20/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <Foundation/Foundation.h>


//电子书列表与视频列表使用，搜索出的信息
@interface GQTCouserBaseInfo : NSObject{
    NSInteger   courseId;       //课程ID
    NSString    *courseName;    //课程名;
    NSString    *courseImage;   //图片地址
    NSString    *courseNote;    //课程介绍
}

@property (assign, nonatomic) NSInteger   courseId;
@property (copy, nonatomic) NSString    *courseName;
@property (copy, nonatomic) NSString    *courseImage;
@property (copy, nonatomic) NSString    *courseNote;

- (id)initWithId:(NSInteger)id courseName:(NSString *)name courseImage:(NSString *)image courseNote:(NSString *)note;
@end


@interface ImageInfo : NSObject{
    NSInteger   imageId;       //图片ID
    NSString    *imageTitle;    //图片名;
    NSString    *imageUrl;   //图片地址
    NSString    *linkURL;    //网页地址
    NSString    *targetId;
    NSString    *type;
    NSString    *note;      
}

@property (assign, nonatomic) NSInteger   imageId;
@property (copy, nonatomic) NSString    *imageTitle;
@property (copy, nonatomic) NSString    *imageUrl;
@property (copy, nonatomic) NSString    *linkURL;
@property (copy, nonatomic) NSString    *targetId;
@property (copy, nonatomic) NSString    *type;
@property (copy, nonatomic) NSString    *note;

@end


//公告，资讯信息list
@interface NoticeInfo : NSObject{
    NSInteger noticeid;
    NSString *createTime;       //创建时间
    NSString *noticeeditor;    //作者
    NSString *noticeimage;     //图片地址
    NSString *noticetitle;     //标题
}

@property (assign, nonatomic) NSInteger   noticeid;
@property (copy, nonatomic) NSString    *createTime;
@property (copy, nonatomic) NSString    *noticeeditor;
@property (copy, nonatomic) NSString    *noticeimage;
@property (copy, nonatomic) NSString    *noticetitle;

@end


@interface NoticeInfoContent : NoticeInfo{
    NSString *noticeContent;
    NSString *noticeSummary;
    NSString *noticeSource;
    NSString *noticeExpiretime;
}

@property (copy, nonatomic) NSString    *noticeContent;
@property (copy, nonatomic) NSString    *noticeSummary;
@property (copy, nonatomic) NSString    *noticeSource;
@property (copy, nonatomic) NSString    *noticeExpiretime;

@end