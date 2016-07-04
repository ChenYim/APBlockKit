//
//  NSObject+APObserveBlock.m
//  APKit
//
//  Created by ChenYim on 16/6/21.
//  Copyright © 2016年 __companyName__. All rights reserved.
//

#import "NSObject+APObserveBlock.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const BOOL kEnableDeallocDesc = YES;

#pragma mark - APEventObserver
@interface APEventObserver : NSObject

// Notification infos
@property (nonatomic, copy) NSString *noteName;
@property (nonatomic, weak) id noteObserveredObject;
@property (nonatomic, weak) NSDictionary *noteUserInfo;
@property (nonatomic, copy) NSString *noteObserveredObjectDesc;
@property (nonatomic, copy) NSString *noteUserInfoDesc;

// Notification callBack block
@property (nonatomic, copy) APEventHandleBlock eventHandleBlock;

@end

@implementation APEventObserver

+ (APEventObserver *)observerWithEvent:(nullable NSString *)aName object:(nullable id)anObject userInfo:(NSDictionary *)userInfo block:(APEventHandleBlock)aBlock
{
    APEventObserver *observer = [APEventObserver new];
    observer.noteName = aName;
    observer.noteObserveredObject = anObject;
    observer.noteUserInfo = userInfo;
    observer.eventHandleBlock = aBlock;
    observer.noteObserveredObjectDesc = [NSString stringWithFormat:@"%@",anObject];
    observer.noteUserInfoDesc = [NSString stringWithFormat:@"%@",userInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(handleNotificationEvent:) name:aName object:anObject];
    
    return observer;
}

// PRIVATE
- (void)handleNotificationEvent:(NSNotification *)notification
{
    !self.eventHandleBlock ? : self.eventHandleBlock(notification);
}

- (void)dealloc
{
    if (kEnableDeallocDesc){
        NSLog(@"%@",[NSString stringWithFormat:@"NSNotificationObserve REMOVED: NOTENAME:%@ | OBSERVED_OBJ:%@ | USERINFO:%@ | BLK:%@", _noteName, _noteObserveredObjectDesc, _noteUserInfoDesc, _eventHandleBlock]);
    }
    _noteName = nil;
    _noteObserveredObject = nil;
    _noteUserInfo = nil;
    _eventHandleBlock = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"NSNotificationObserve REMOVED: NOTENAME:%@ | OBSERVED_OBJ:%@ | USERINFO:%@ | BLK:%@", _noteName, _noteObserveredObjectDesc, _noteUserInfoDesc, _eventHandleBlock];
}

@end

#pragma mark - APKeyPathObserver

@interface APKeyPathObserver : NSObject

// KVO infos
@property (nonatomic, copy) NSString *kvo_keyPath;
@property (nonatomic, weak) id kvo_objectRef; 
@property (nonatomic, assign) NSKeyValueObservingOptions kvo_options;
@property (nonatomic, assign) NSInteger kvo_tag;

// KVO callBack block
@property (nonatomic, copy) APKeyPathHandleBlock keyPathHandleBlock;
@end

@implementation APKeyPathObserver

+ (APKeyPathObserver *)observerWithKeyPath:(nullable NSString *)keyPath object:(nullable id)anObject options:(NSKeyValueObservingOptions)options Tag:(NSInteger)tag block:(APKeyPathHandleBlock)aBlock
{
    APKeyPathObserver *keyPathObserver = [APKeyPathObserver new];
    keyPathObserver.kvo_keyPath = keyPath;
    keyPathObserver.kvo_objectRef = anObject;
    keyPathObserver.kvo_options = options;
    keyPathObserver.kvo_tag = tag;
    keyPathObserver.keyPathHandleBlock = aBlock;
    
    [anObject addObserver:keyPathObserver forKeyPath:keyPath options:options context:NULL];
    
    return keyPathObserver;
}

// Overwrite
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    !self.keyPathHandleBlock ? : self.keyPathHandleBlock(keyPath, object, change);
}

- (void)dealloc
{
    if (kEnableDeallocDesc){
        NSLog(@"%@",[NSString stringWithFormat:@"KEYPATH REMOVED: KEYPATH:%@ | OBJREF:%@ | OPTIONS:%@ | TAG:%@ | BLK:%@", _kvo_keyPath, _kvo_objectRef, @(_kvo_options), @(_kvo_tag), _keyPathHandleBlock]);
    }
    
    [_kvo_objectRef removeObserver:self forKeyPath:_kvo_keyPath context:NULL];
    _kvo_keyPath = nil;
    _kvo_objectRef = nil;
    _kvo_options = 0;
    _kvo_tag = 0;
    _keyPathHandleBlock = nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"KEYPATH REMOVED: KEYPATH:%@ | OBJREF:%@ | OPTIONS:%@ | TAG:%@ | BLK:%@", _kvo_keyPath, _kvo_objectRef, @(_kvo_options), @(_kvo_tag), _keyPathHandleBlock];
}

@end

#pragma mark - AssociatedObserverMapManager
@interface AssociatedObserverMapManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *eventObserverMap;
@property (nonatomic, strong) NSMutableDictionary *kvoObserverMap;

@end

@implementation AssociatedObserverMapManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.eventObserverMap = [NSMutableDictionary new];
        self.kvoObserverMap   = [NSMutableDictionary new];
    }
    return self;
}

- (void)dealloc
{
    self.eventObserverMap = nil;
    self.kvoObserverMap = nil;
    
    if (kEnableDeallocDesc) {
        NSLog(@"AssociatedObjMap(%@) Dealloced....",self);
    }
}

@end

#pragma mark - NSObject (APObserveBlock)

@implementation NSObject (APObserveBlock)

#pragma mark - Private Method

- (AssociatedObserverMapManager *)observerMapManager
{
    static void * kAssociatedObserverMapManager = "kAssociatedObserverMapManager";
    AssociatedObserverMapManager *mapManager = (AssociatedObserverMapManager *)objc_getAssociatedObject(self, kAssociatedObserverMapManager);
    if (mapManager == nil){
        mapManager = [AssociatedObserverMapManager new];
        objc_setAssociatedObject(self, kAssociatedObserverMapManager, mapManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mapManager;
}

- (NSMutableDictionary *)eventObserverMap
{
    NSMutableDictionary *mDic = [[self observerMapManager] eventObserverMap];
    return mDic;
}

- (NSMutableDictionary *)keyPathObserverMap
{
    NSMutableDictionary *mDic = [[self observerMapManager] kvoObserverMap];
    return mDic;
}

#pragma mark - Public Method

- (void)postEvent:(NSString *)aName userInfo:(NSDictionary *)aUserInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:self userInfo:aUserInfo];
}

- (void)observeEvent:(NSString *)aName object:(id)anObject block:(APEventHandleBlock)aBlock
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:anObject];
    
    NSMutableDictionary *eventObserverMap = [self eventObserverMap];
    APEventObserver *observer = [APEventObserver observerWithEvent:aName object:anObject userInfo:nil block:aBlock];
    NSString *akey = [NSString stringWithFormat:@"%@_%p_%p", aName, anObject, aBlock];
    [eventObserverMap setObject:observer forKey:akey];
}

- (void)unObserveObject:(id)anObject
{
    [self unObserveEvent:nil object:anObject];
}

- (void)unObserveEvent:(NSString *)aName
{
    [self unObserveEvent:aName object:nil];
}

- (void)unObserveEvents
{
    [self unObserveEvent:nil object:nil];
}

- (void)unObserveEvent:(NSString *)aName object:(id)anObject
{
    __block NSMutableDictionary *eventObserverMap = [self eventObserverMap];
    NSArray *allKeys = [eventObserverMap allKeys];
    
    if (aName == nil && anObject == nil) {
        [eventObserverMap removeAllObjects];
        return;
    }
    else if (aName != nil && anObject == nil){ // Remove eventName related observingEvent
        
        [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            NSString *aAssociateObserverDicKey = obj;
            BOOL isInvolved = ([aAssociateObserverDicKey rangeOfString:aName].location != NSNotFound) ? YES : NO;
            !isInvolved ? : [eventObserverMap removeObjectForKey:aAssociateObserverDicKey];
        }];
    }
    else if (aName == nil && anObject != nil){ // Remove eventSender related observingEvent
        
        [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *aAssociateObserverDicKey = obj;
            NSString *aKeyFragment = [NSString stringWithFormat:@"%p",anObject];
            BOOL isInvolved = ([aAssociateObserverDicKey rangeOfString:aKeyFragment].location != NSNotFound) ? YES : NO;
            !isInvolved ? : [eventObserverMap removeObjectForKey:aAssociateObserverDicKey];
        }];
    }
    else if (aName != nil && anObject != nil){ // Remove specific observingEvent by eventName && eventSender
        
        NSString *aKeyFragment = [NSString stringWithFormat:@"%@_%p", aName, anObject];
        [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *aAssociateObserverDicKey = obj;
            BOOL isInvolved = ([aAssociateObserverDicKey rangeOfString:aKeyFragment].location != NSNotFound) ? YES : NO;
            !isInvolved ? : [eventObserverMap removeObjectForKey:aAssociateObserverDicKey];
        }];
    }
}

- (void)observeKeyPath:(NSString *)keyPath object:(id)anObject options:(NSKeyValueObservingOptions)options Tag:(NSInteger)tag block:(APKeyPathHandleBlock)aBlock
{
    if (keyPath.length == 0 || anObject == nil) {
        @throw [NSException exceptionWithName:@"observeKeyPath received invalid params" reason:nil userInfo:nil];
    }
    
    NSMutableDictionary *keyPathObserverMap = [self keyPathObserverMap];
    APKeyPathObserver *observer = [APKeyPathObserver observerWithKeyPath:keyPath object:anObject options:options Tag:tag block:aBlock];
    NSString *akey = [NSString stringWithFormat:@"%@_%p_%@_%p", keyPath, anObject, @(tag), aBlock];
    [keyPathObserverMap setObject:observer forKey:akey];
}

- (void)unObserveKeyPath:(NSString *)keyPath object:(id)anObject Tag:(NSInteger)tag
{
    if (keyPath.length == 0 || anObject == nil) {
        @throw [NSException exceptionWithName:@"observeKeyPath received invalid params" reason:nil userInfo:nil];
    }
    
    NSMutableDictionary *keyPathObserverMap = [self keyPathObserverMap];
    NSArray *allKeys = [keyPathObserverMap allKeys];
    NSString *aKeyFragment = [NSString stringWithFormat:@"%@_%p_%@_", keyPath, anObject, @(tag)];
    [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isInvolved = ([obj rangeOfString:aKeyFragment].location != NSNotFound) ? YES : NO;
        !isInvolved ? : [keyPathObserverMap removeObjectForKey:obj];
    }];
}

- (void)unObserveKeyPathOfObject:(id)anObject
{
    NSMutableDictionary *keyPathObserverMap = [self keyPathObserverMap];
    NSArray *allKeys = [keyPathObserverMap allKeys];
    NSString *aKeyFragment = [NSString stringWithFormat:@"_%p_", anObject];
    [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isInvolved = ([obj rangeOfString:aKeyFragment].location != NSNotFound) ? YES : NO;
        !isInvolved ? : [keyPathObserverMap removeObjectForKey:obj];
    }];
}

- (void)unObserveAllKeyPaths
{
    NSMutableDictionary *keyPathObserverMap = [self keyPathObserverMap];
    [keyPathObserverMap removeAllObjects];
}

@end
