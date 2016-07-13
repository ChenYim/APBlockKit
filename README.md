# APBlockKit
APBlockKit is a simple block-Handle Util  
[Thanks:https://github.com/refusebt/RFEvent]  
[Swift Version:https://github.com/LucioLee/LucioClosureKit]

###NSNotification Observing 


######Tip: It's not necessary to invoke unObserveEvents in -(void)dealloc, it will it for you automatically when self is about to be deallocated.

* -(void)postEvent:(NSString *)aName userInfo:(NSDictionary *)aUserInfo;

* -(void)observeEvent:(NSString *)aName object:(id)anObject block:(APEventHandleBlock)aBlock;

* -(void)unObserveEvent:(NSString *)aName;

* -(void)unObserveEvents;

* -(void)unObserveObject:(id)anObject;

* -(void)unObserveEvent:(NSString *)aName object:(id)anObject;

###KeyValueObserving 

###### Tip1: You need to unObserve the KeyPath that you have set to observed to prevent crash : kvo_objectRef was deallocated while key value observers were still registered with it.

###### Tip2: Tag is designed to mark the keyPath observer when regist or cancel.


* -(void)observeKeyPath:(NSString *)keyPath object:(id)anObject options:(NSKeyValueObservingOptions)options Tag:(NSInteger)tag block:(APKeyPathHandleBlock)aBlock;

* -(void)unObserveKeyPath:(NSString *)keyPath object:(id)anObject Tag:(NSInteger)tag;

* -(void)unObserveKeyPathOfObject:(id)anObject;

* -(void)unObserveAllKeyPaths;
