//
//  LJNotification.h
//  NSNotificationCenterDemo
//
//  Created by blue on 2017/10/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *LJNotificationName NS_EXTENSIBLE_STRING_ENUM;

NS_ASSUME_NONNULL_BEGIN

@class NSString, NSDictionary, NSOperationQueue;
@interface LJNotification : NSObject
@property (readonly, copy) LJNotificationName name;
@property (nullable, readonly, retain) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;

- (instancetype)initWithName:(LJNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0)) NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;


+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject;
+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;
- (instancetype)init;
@end


NS_ASSUME_NONNULL_END
