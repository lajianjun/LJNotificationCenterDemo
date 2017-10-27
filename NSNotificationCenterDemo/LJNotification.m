//
//  LJNotification.m
//  NSNotificationCenterDemo
//
//  Created by blue on 2017/10/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJNotification.h"

@implementation LJNotification

- (instancetype)initWithName:(LJNotificationName)name object:(id)object userInfo:(NSDictionary *)userInfo{
    if (self = [super init]) {
        _name = name;
        _object = object;
        _userInfo = userInfo;
    }
    return self;
}
- (instancetype)init{
    if ([self init]) {
        
    }
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    return nil;
}

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject{
    return [[self alloc] initWithName:aName object:anObject userInfo:nil];
}
+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo{
    return [[self alloc] initWithName:aName object:anObject userInfo:aUserInfo];
}
@end
