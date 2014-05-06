//
//  GQTUserInfo.m
//  learning_OC
//
//  Created by test on 4/8/13.
//  Copyright (c) 2013 viktyz. All rights reserved.
//

#import "GQTUserInfo.h"

@implementation GQTUserInfo

@synthesize userArea;
@synthesize userId;
@synthesize userLogin;
@synthesize userNike;
@synthesize userPhone;
@synthesize UserEmail;
@synthesize areaId;


- (void)dealloc{
    [userPhone release];
    [userNike release];
    [userLogin release];
    [UserEmail release];
    [userArea release];
    
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.areaId = [aDecoder decodeIntegerForKey:@"areaId"];
        
        self.userLogin = [aDecoder decodeObjectForKey:@"userLogin"];
        self.userNike = [aDecoder decodeObjectForKey:@"userNike"];
        self.userPhone = [aDecoder decodeObjectForKey:@"userPhone"];
        self.UserEmail = [aDecoder decodeObjectForKey:@"UserEmail"];
        self.userArea = [aDecoder decodeObjectForKey:@"userArea"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:userLogin forKey:@"userLogin"];
    [aCoder encodeObject:userNike forKey:@"userNike"];
    [aCoder encodeObject:userPhone forKey:@"userPhone"];
    [aCoder encodeObject:UserEmail forKey:@"UserEmail"];
    [aCoder encodeObject:userArea forKey:@"userArea"];
    
    [aCoder encodeInteger:userId forKey:@"userId"];
    [aCoder encodeInteger:areaId forKey:@"areaId"];
}

@end


@implementation GQTLowerArea

@synthesize lowerId;
@synthesize lowerCode;
@synthesize lowerName;
@synthesize lowerShortName;

- (void)dealloc{
    [lowerCode release];
    [lowerName release];
    [lowerShortName release];
    
    [super dealloc];
}

@end

@implementation GQTypeInfo

@synthesize typeId;
@synthesize typeName;
@synthesize isLeaf;

- (void)dealloc{
    [typeName release];
    
    [super dealloc];
}

@end
