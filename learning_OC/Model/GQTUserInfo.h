//
//  GQTUserInfo.h
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GQTUserInfo : NSObject<NSCoding>{
    NSString  *userLogin;       //用户名
    NSString  *userNike;        //昵称
    NSString  *userArea;        //区域名
    NSString  *UserEmail;           //邮件地址
    NSString  *userPhone;           //电话号码
    NSInteger  areaId;          //区域Id
    NSInteger userId;         //用户id
}

@property (retain, nonatomic) NSString  *userLogin;
@property (retain, nonatomic) NSString  *userNike;
@property (retain, nonatomic) NSString  *userArea;
@property (retain, nonatomic) NSString  *UserEmail;
@property (retain, nonatomic) NSString  *userPhone;
@property (assign, nonatomic) NSInteger  areaId;
@property (assign, nonatomic) NSInteger userId;

@end

//lowerArea{
//    lowerId id
//    lowercode 区域code
//    lowershortname 区域拼音
//    lowername 区域名
//}

@interface GQTLowerArea : NSObject{
    NSInteger lowerId;
    NSString *lowerCode;
    NSString *lowerShortName;
    NSString *lowerName;
}

@property (assign, nonatomic) NSInteger lowerId;

@property (copy, nonatomic) NSString *lowerCode;
@property (copy, nonatomic) NSString *lowerShortName;
@property (copy, nonatomic) NSString *lowerName;

@end

//"typeName":"团 员","isLeaf":false,"typeId":2

@interface GQTypeInfo : NSObject{
    NSInteger typeId;
    NSString *typeName;
    BOOL    isLeaf;
}

@property (assign, nonatomic) NSInteger typeId;
@property (retain, nonatomic) NSString *typeName;
@property (assign, nonatomic) BOOL    isLeaf;

@end
