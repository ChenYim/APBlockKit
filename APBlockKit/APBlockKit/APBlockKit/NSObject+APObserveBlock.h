//
//  NSObject+APObserveBlock.h
//  APKit
//
//  Created by ChenYim on 16/6/21.
//  Copyright © 2016年 __companyName__. All rights reserved.
//

/**
 *  Thanks : Refusebt https://github.com/refusebt/RFEvent
 *
 */

#import <Foundation/Foundation.h>

typedef void (^APEventHandleBlock) (NSNotification *aNote);
typedef void (^APKeyPathHandleBlock) (NSString *keyPath, id object, NSDictionary<NSString *,id> *change);

@interface NSObject (APObserveBlock)

// === NSNotification Observing ===
//
// Tip: It's not necessary to invoke unObserveEvents in -(void)dealloc, it will it for you automatically when self is about to be deallocated.
//
// ================================
- (void)postEvent:(NSString *)aName userInfo:(NSDictionary *)aUserInfo;
- (void)observeEvent:(NSString *)aName object:(id)anObject block:(APEventHandleBlock)aBlock;
- (void)unObserveEvent:(NSString *)aName;
- (void)unObserveEvents;
- (void)unObserveObject:(id)anObject;
- (void)unObserveEvent:(NSString *)aName object:(id)anObject;


// ======= KVO Observing =======
//
// Tip: You need to unObserve the KeyPath that you have set to observed to prevent crash : kvo_objectRef was deallocated while key value observers were still registered with it.
// Tip: Tag is designed to mark the keyPath observer when regist or cancel.
// =============================
- (void)observeKeyPath:(NSString *)keyPath object:(id)anObject options:(NSKeyValueObservingOptions)options Tag:(NSInteger)tag block:(APKeyPathHandleBlock)aBlock;
- (void)unObserveKeyPath:(NSString *)keyPath object:(id)anObject Tag:(NSInteger)tag;
- (void)unObserveKeyPathOfObject:(id)anObject;
- (void)unObserveAllKeyPaths;

@end
