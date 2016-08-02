# APBlockKit
APBlockKit is a simple Block-handle Util.

* [Thanks:https://github.com/refusebt/RFEvent]  
* [Swift Version:https://github.com/LucioLee/LucioClosureKit]

---
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

---
###UIKit Block-handle
```
@interface UIAlertView (APBlockHandler)<UIAlertViewDelegate>

+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtonTitles
                              Click:(APAlertView_block_self_index)clickBlk;

- (void)handlerClickedButton:(APAlertView_block_self_index)aBlock;
- (void)handlerCancel:(APAlertView_block_self)aBlock;
- (void)handlerWillPresent:(APAlertView_block_self)aBlock;
- (void)handlerDidPresent:(APAlertView_block_self)aBlock;
- (void)handlerWillDismiss:(APAlertView_block_self_index)aBlock;
- (void)handlerDidDismiss:(APAlertView_block_self_index)aBlock;
- (void)handlerShouldEnableFirstOtherButton:(APAlertView_block_shouldEnableFirstOtherButton)aBlock;

// 延时消失
- (void)showWithDuration:(NSTimeInterval)i;

@end
```
```
@interface UIActionSheet (APBlockHandler)<UIActionSheetDelegate>

+ (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles click:(UIActionSheet_block_self_index)clickBlk;

- (void)handlerClickedButton:(UIActionSheet_block_self_index)aBlock;
- (void)handlerCancel:(UIActionSheet_block_self)aBlock;
- (void)handlerWillPresent:(UIActionSheet_block_self)aBlock;
- (void)handlerDidPresent:(UIActionSheet_block_self)aBlock;
- (void)handlerWillDismiss:(UIActionSheet_block_self)aBlock;
- (void)handlerDidDismiss:(UIActionSheet_block_self_index)aBlock;

@end
```
```
@interface UITextField (APBlockHandler)

-(void)ap_setPlactHolderStr:(NSString *)str;
-(void)ap_setDismissKeyBoardOnReturn;

- (void)handleDidBeginEditing:(APTextField_Block_Self)aBlock;
- (void)handleDidEndEditing:(APTextField_Block_Self)aBlock;
- (void)handleShouldBeginEditing:(APTextField_BoolBlock_Self)aBlock;
- (void)handleShouldEndEditing:(APTextField_BoolBlock_Self)aBlock;
- (void)handleShouldChangeCharactersInRange:(APTextField_Block_Self_Range_ReplaceText)aBlock;
- (void)handleShouldClear:(APTextField_BoolBlock_Self)aBlock;
- (void)handleShouldReturn:(APTextField_BoolBlock_Self)aBlock;

@end
```
```
@interface UITextView (APBlockHandler)

- (void)ap_setPlactHolderStr:(NSString *)str;
- (void)ap_setDismissKeyBoardOnReturn;

- (void)handleShouldBeginEditing:(APTextView_BOOLBlock_Self)aBlock;
- (void)handleShouldEndEditing:(APTextView_BOOLBlock_Self)aBlock;
- (void)handleDidBeginEditing:(APTextView_Block_Self)aBlock;
- (void)handleDidEndEditing:(APTextView_Block_Self)aBlock;
- (void)handleShouldChangeTextInRange:(APTextView_BOOLBlock_Self_Range_ReplaceText)aBlock;
- (void)handleDidChange:(APTextView_Block_Self)aBlock;

@end
```


