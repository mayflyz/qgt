//
//  GQTBookInfo.h
//  learning_OC
//
//  Created by test on 3/20/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CourseTypeBook = 0,
    CourseTypeVideo
}CourseType;

@interface GQTBookInfo : NSObject{
    NSInteger bookId;
    NSString *bookName;
    NSString *bookAuthor;
    NSString *bookImage;
    NSString *bookNote;
    NSString *categoryCode;
    NSInteger categoryId;
    NSString *categoryName;
    
    NSInteger teacherId;
    NSString *teacherName;
    CourseType type;
}

@property (assign, nonatomic)  NSInteger bookId;
@property (retain, nonatomic) NSString *bookName;
@property (retain, nonatomic) NSString *bookAuthor;
@property (retain, nonatomic) NSString *bookImage;
@property (retain, nonatomic) NSString *bookNote;

@property (assign, nonatomic)  NSInteger categoryId;
@property (retain, nonatomic) NSString *categoryCode;
@property (retain, nonatomic) NSString *categoryName;

@property (assign, nonatomic) NSInteger teacherId;
@property (retain, nonatomic) NSString *teacherName;
@property (assign, nonatomic) CourseType type;

@end

typedef enum {
    BookTypeText = 1,
    BookTypeImage
}BookType;

@interface GQTBOOKContentInfo : NSObject{
    NSInteger contentId;
    NSString *bookAuthor;        //作者
    NSString *contentTitle;      //章节标题
    NSString *bookName;          //书名
    NSInteger bookId;            //书ID
    NSInteger contentPage;       //章节数
    NSString *content;           //内容(分为图书电书和文字电子书..判断string 是不是以/开头 )
    BookType type;
}

@property (assign, nonatomic) BookType type;
@property (assign, nonatomic) NSInteger contentId;
@property (retain, nonatomic) NSString *bookAuthor;
@property (retain, nonatomic) NSString *contentTitle;
@property (retain, nonatomic) NSString *bookName;
@property (assign, nonatomic) NSInteger bookId;
@property (assign, nonatomic) NSInteger contentPage;
@property (retain, nonatomic) NSString *content;

@end


@interface GQTBookChapterInfo : NSObject {
    NSInteger chapterId;
    NSString  *chapterTitle;
    NSInteger chapterPageNumber;
}

@property (assign, nonatomic) NSInteger chapterId;
@property (retain, nonatomic) NSString  *chapterTitle;
@property (assign, nonatomic) NSInteger chapterPageNumber;
@end

@interface GQTVideoChapterInfo : NSObject{
    NSInteger videoChapterId;
    NSInteger videoTime;
    NSString  *videoUrl;
    NSString  *videoName;
    NSString  *videoTeacherName;
    NSInteger videoTeacherId;
    
}
@property (assign, nonatomic) NSInteger videoChapterId;
@property (assign, nonatomic) NSInteger videoTime;
@property (retain, nonatomic) NSString  *videoUrl;
@property (retain, nonatomic) NSString  *videoName;

@property (retain, nonatomic) NSString  *videoTeacherName;
@property (assign, nonatomic) NSInteger videoTeacherId;
@end
