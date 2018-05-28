//
//  UITableView+APBlockHandler.h
//  TestApp
//
//  Created by ChenYim on 15/12/21.
//  Copyright © 2015年 __companyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// delegate
typedef CGFloat (^APTableViewBlk_heightForHeaderInSection)(UITableView *tableView, NSInteger section);
typedef CGFloat (^APTableViewBlk_heightForFooterInSection)(UITableView *tableView, NSInteger section);
typedef CGFloat (^APTableViewBlk_heightForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
typedef UIView * (^APTableViewBlk_viewForHeaderInSection)(UITableView *tableView, NSInteger section);
typedef UIView * (^APTableViewBlk_viewForFooterInSection)(UITableView *tableView, NSInteger section);
typedef void(^APTableViewBlk_didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
// datasource
typedef NSInteger(^APTableViewBlk_numberOfSection)(UITableView *tableView);
typedef NSInteger(^APTableViewBlk_numberOfRowsInSection)(UITableView *tableView, NSInteger section);
typedef UITableViewCell * (^APTableViewBlk_cellForRowAtIndex)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSString * (^APTableViewBlk_titleForHeaderInSection)(UITableView *tableView, NSInteger section);
typedef NSString * (^APTableViewBlk_titleForFooterInSection)(UITableView *tableView, NSInteger section);

typedef BOOL (^APTableViewBlk_canEditRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
typedef BOOL (^APTableViewBlk_canMoveRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

typedef void (^APTableViewBlk_commitEditingStyle)(UITableView *tableView, UITableViewCellEditingStyle style, NSIndexPath *indexPath);
typedef void (^APTableViewBlk_moveRowAtIndexPath)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);



@interface UITableView (APBlockHandler)

// Delegate
- (void)handleHeightForHeaderInSection:(APTableViewBlk_heightForHeaderInSection)blk; // block-nil default:0
- (void)handleHeightForFooterInSection:(APTableViewBlk_heightForFooterInSection)blk; // block-nil default:0
- (void)handleHeightForRowAtIndexPath:(APTableViewBlk_heightForRowAtIndexPath)blk;   // block-nil default:44.0
- (void)handleViewForHeaderInSection:(APTableViewBlk_viewForHeaderInSection)blk;     // block-nil default:nil
- (void)handleViewForFooterInSection:(APTableViewBlk_viewForFooterInSection)blk;          // block-nil default:nil
- (void)handleDidSelectRowAtIndexPath:(APTableViewBlk_didSelectRowAtIndexPath)blk;

// Datasource
- (void)handleNumberOfSection:(APTableViewBlk_numberOfSection)blk;
- (void)handleNumberOfRowsInSection:(APTableViewBlk_numberOfRowsInSection)blk;
- (void)handleCellForRowAtIndex:(APTableViewBlk_cellForRowAtIndex)blk;
- (void)handleTitleForHeaderInSection:(APTableViewBlk_titleForHeaderInSection)blk;
- (void)handleTitleForFooterInSection:(APTableViewBlk_titleForFooterInSection)blk;

- (void)handleCanEditRowAtIndexPath:(APTableViewBlk_canEditRowAtIndexPath)blk;
- (void)handleCanMoveRowAtIndexPath:(APTableViewBlk_canMoveRowAtIndexPath)blk;
- (void)handleCommitEditingStyle:(APTableViewBlk_commitEditingStyle)blk;
- (void)handleMoveRowAtIndexPath:(APTableViewBlk_moveRowAtIndexPath)blk;
@end
