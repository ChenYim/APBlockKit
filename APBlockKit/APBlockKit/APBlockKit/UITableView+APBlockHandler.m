//
//  UITableView+APBlockHandler.m
//  TestApp
//
//  Created by ChenYim on 15/12/21.
//  Copyright © 2015年 9Sky. All rights reserved.
//
static const char APTableViewKey_APBlockHandler;

#import "UITableView+APBlockHandler.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@interface APTableViewBlockHandler : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) APTableViewBlk_heightForHeaderInSection heightForHeaderInSection;
@property (nonatomic, copy) APTableViewBlk_heightForFooterInSection heightForFooterInSection;
@property (nonatomic, copy) APTableViewBlk_heightForRowAtIndexPath  heightForRowAtIndexPath;
@property (nonatomic, copy) APTableViewBlk_didSelectRowAtIndexPath  didSelectRowAtIndexPath;
@property (nonatomic, copy) APTableViewBlk_viewForHeaderInSection   viewForHeaderInSection;
@property (nonatomic, copy) APTableViewBlk_viewForFooterInSection   viewForFooterInSection;

@property (nonatomic, copy) APTableViewBlk_numberOfSection         numberOfSection;
@property (nonatomic, copy) APTableViewBlk_numberOfRowsInSection   numberOfRowsInSection;
@property (nonatomic, copy) APTableViewBlk_cellForRowAtIndex       cellForRowAtIndex;
@property (nonatomic, copy) APTableViewBlk_titleForHeaderInSection titleForHeaderInSection;
@property (nonatomic, copy) APTableViewBlk_titleForFooterInSection titleForFooterInSection;
@property (nonatomic, copy) APTableViewBlk_canEditRowAtIndexPath   canEditRowAtIndexPath;
@property (nonatomic, copy) APTableViewBlk_canMoveRowAtIndexPath   canMoveRowAtIndexPath;
@property (nonatomic, copy) APTableViewBlk_commitEditingStyle      commitEditingStyle;
@property (nonatomic, copy) APTableViewBlk_moveRowAtIndexPath      moveRowAtIndexPath;
@end



@implementation APTableViewBlockHandler

#pragma mark - 	UITableViewDataSource && UITableViewDelegate

// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    APTableViewBlk_heightForHeaderInSection blk = self.heightForHeaderInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    APTableViewBlk_heightForFooterInSection blk = self.heightForFooterInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    APTableViewBlk_heightForRowAtIndexPath blk = self.heightForRowAtIndexPath;
    if (blk) {
        return blk(tableView, indexPath);
    }
    else
        return 44.0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    APTableViewBlk_viewForHeaderInSection blk = self.viewForHeaderInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    APTableViewBlk_viewForFooterInSection blk = self.viewForFooterInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    APTableViewBlk_didSelectRowAtIndexPath blk = self.didSelectRowAtIndexPath;
    if (blk) {
        blk(tableView, indexPath);
    }
}


// datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    APTableViewBlk_numberOfSection blk = self.numberOfSection;
    if (blk) {
        return blk(tableView);
    }
    else
        return 1;
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    APTableViewBlk_numberOfRowsInSection blk = self.numberOfRowsInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return 0;
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    APTableViewBlk_cellForRowAtIndex blk = self.cellForRowAtIndex;
    if (blk) {
        return blk(tableView, indexPath);
    }
    else
        return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    APTableViewBlk_titleForHeaderInSection blk = self.titleForHeaderInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return nil;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    APTableViewBlk_titleForFooterInSection blk = self.titleForFooterInSection;
    if (blk) {
        return blk(tableView, section);
    }
    else
        return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    APTableViewBlk_canEditRowAtIndexPath blk = self.canEditRowAtIndexPath;
    if (blk) {
        return blk(tableView, indexPath);
    }
    else
        return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    APTableViewBlk_canMoveRowAtIndexPath blk = self.canMoveRowAtIndexPath;
    if (blk) {
        return blk(tableView, indexPath);
    }
    else
        return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    APTableViewBlk_commitEditingStyle blk = self.commitEditingStyle;
    if (blk) {
        blk(tableView, editingStyle, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    APTableViewBlk_moveRowAtIndexPath blk = self.moveRowAtIndexPath;
    if (blk) {
        blk(tableView, sourceIndexPath, destinationIndexPath);
    }
}

@end

@interface UITableView()
@end

@implementation UITableView (APBlockHandler)
// private
-(APTableViewBlockHandler *)ap_getAPBlockHandler
{
    APTableViewBlockHandler *blkHandler_MayNil = objc_getAssociatedObject(self, &APTableViewKey_APBlockHandler);
    if (!blkHandler_MayNil) {
        objc_setAssociatedObject(self, &APTableViewKey_APBlockHandler, [APTableViewBlockHandler new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    APTableViewBlockHandler *blockHandler = objc_getAssociatedObject(self, &APTableViewKey_APBlockHandler);
    self.dataSource = blockHandler;
    self.delegate = blockHandler;
    return blockHandler;
}

// delegate
- (void)handleHeightForHeaderInSection:(APTableViewBlk_heightForHeaderInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.heightForHeaderInSection = blk;
//    self.delegate = handler;
}

- (void)handleHeightForFooterInSection:(APTableViewBlk_heightForFooterInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.heightForFooterInSection = blk;
//    self.delegate = handler;
}

- (void)handleHeightForRowAtIndexPath:(APTableViewBlk_heightForRowAtIndexPath)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.heightForRowAtIndexPath = blk;
//    self.delegate = handler;
}

- (void)handleViewForHeaderInSection:(APTableViewBlk_viewForHeaderInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.viewForHeaderInSection = blk;
//    self.delegate = handler;
}

- (void)handleViewForFooterInSection:(APTableViewBlk_viewForFooterInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.viewForFooterInSection = blk;
//    self.delegate = handler;
}

- (void)handleDidSelectRowAtIndexPath:(APTableViewBlk_didSelectRowAtIndexPath)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.didSelectRowAtIndexPath = blk;
//    self.delegate = handler;
}

// dataSource
- (void)handleNumberOfSection:(APTableViewBlk_numberOfSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.numberOfSection = blk;
//    self.dataSource = handler;
}

- (void)handleNumberOfRowsInSection:(APTableViewBlk_numberOfRowsInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.numberOfRowsInSection = blk;
//    self.dataSource = handler;
}

- (void)handleCellForRowAtIndex:(APTableViewBlk_cellForRowAtIndex)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.cellForRowAtIndex = blk;
//    self.dataSource = handler;
}

- (void)handleTitleForHeaderInSection:(APTableViewBlk_titleForHeaderInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.titleForHeaderInSection = blk;
//    self.dataSource = handler;
}

- (void)handleTitleForFooterInSection:(APTableViewBlk_titleForFooterInSection)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.titleForFooterInSection = blk;
//    self.dataSource = handler;
}

- (void)handleCanEditRowAtIndexPath:(APTableViewBlk_canEditRowAtIndexPath)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.canEditRowAtIndexPath = blk;
//    self.dataSource = handler;
}

- (void)handleCanMoveRowAtIndexPath:(APTableViewBlk_canMoveRowAtIndexPath)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.canMoveRowAtIndexPath = blk;
//    self.dataSource = handler;
}

- (void)handleCommitEditingStyle:(APTableViewBlk_commitEditingStyle)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.commitEditingStyle = blk;
//    self.dataSource = handler;
}

- (void)handleMoveRowAtIndexPath:(APTableViewBlk_moveRowAtIndexPath)blk
{
    APTableViewBlockHandler *handler = [self ap_getAPBlockHandler];
    handler.moveRowAtIndexPath = blk;
//    self.dataSource = handler;
}
@end
