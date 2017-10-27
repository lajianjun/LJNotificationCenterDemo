//
//  LJNotificationCenter.m
//  NSNotificationCenterDemo
//
//  Created by blue on 2017/10/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "LJNotificationCenter.h"

typedef void(^OperationBlock)(LJNotification *notification);
@interface LJObserverModel : NSObject
@property (nonatomic,strong) id observer;
@property (nonatomic,assign) SEL selector;
@property (nonatomic,copy) NSString *notificationName;
@property (nonatomic,strong) id object;
@property (nonatomic,strong)NSOperationQueue *operationQueue;
@property (nonatomic,copy) OperationBlock block;
@end

@implementation LJObserverModel

@end

@interface LJNotificationCenter()
@property (nonatomic, strong) NSMutableArray *observers;
@end

@implementation LJNotificationCenter
+ (LJNotificationCenter*)defaultCenter{
    static LJNotificationCenter *objectCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objectCenter = [[self alloc] initSingleton];
    });
    return objectCenter;
}
- (instancetype)initSingleton{
    if ([super init]) {
        _observers = [NSMutableArray array];
    }
    return self;
}


- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString*)aName object:(nullable id)anObject{
    LJObserverModel *observerModel = [[LJObserverModel alloc] init];
    observerModel.observer = observer;
    observerModel.selector = aSelector;
    observerModel.notificationName = aName;
    observerModel.object = anObject;
    [self.observers addObject:observerModel];
}

- (void)postNotification:(LJNotification *)notification{
    
    [self.observers enumerateObjectsUsingBlock:^(LJObserverModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LJObserverModel *observerModel = obj;
        id observer = observerModel.observer;
        SEL selector = observerModel.selector;
        if (!observerModel.operationQueue) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [observer performSelector:selector withObject:notification];
#pragma clang diagnostic pop
        }else{
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                observerModel.block(notification);
            }];
            NSOperationQueue *operationQueue = observerModel.operationQueue;
            [operationQueue addOperation:operation];
        }
    }];
    
}
- (void)postNotificationName:(NSString*)aName object:(nullable id)anObject{
    [self postNotificationName:aName object:anObject userInfo:nil];
}
- (void)postNotificationName:(NSString*)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo{
    LJNotification *notification = [[LJNotification alloc]initWithName:aName object:anObject userInfo:aUserInfo];
    [self postNotification:notification];
}

- (void)removeObserver:(id)observer{
    [self removeObserver:observer name:nil object:nil];
}
- (void)removeObserver:(id)observer name:(nullable NSString*)aName object:(nullable id)anObject{
    
    [self.observers enumerateObjectsUsingBlock:^(LJObserverModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LJObserverModel *observerModel = obj;
        if ([aName isEqualToString:observerModel.notificationName] && observer == observerModel.observer && anObject == observerModel.object) {
            [self.observers removeObject:observerModel];
            *stop = YES;
        }
    }];
}

- (id <NSObject>)addObserverForName:(nullable NSString*)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(LJNotification * _Nonnull))block {
    LJObserverModel *observerModel = [[LJObserverModel alloc] init];
    observerModel.notificationName = name;
    observerModel.object = obj;
    observerModel.operationQueue = queue;
    observerModel.block = block;
    [self.observers addObject:observerModel];
    return nil;
}

@end
