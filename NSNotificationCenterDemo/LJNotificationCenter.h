//
//  LJNotificationCenter.h
//  NSNotificationCenterDemo
//
//  Created by blue on 2017/10/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJNotification.h"

NS_ASSUME_NONNULL_BEGIN
@interface LJNotificationCenter : NSObject
+ (LJNotificationCenter*)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString*)aName object:(nullable id)anObject;

- (void)postNotification:(LJNotification *)notification;
- (void)postNotificationName:(NSString*)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString*)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;


- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString*)aName object:(nullable id)anObject;

- (id <NSObject>)addObserverForName:(nullable NSString*)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(LJNotification *note))block API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

@end
NS_ASSUME_NONNULL_END
