//
//  HXCollectionTableView.h
//  CollectionInfoDemo
//
//  Created by huixiang on 2017/9/7.
//  Copyright © 2017年 Huixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXInfoTableViewCell;

@interface HXCollectionTableView : UITableView

@end

@protocol HXInfoTableViewCellDelegate <NSObject>

- (void)hxInfoTableViewCell:(HXInfoTableViewCell *)cell didEndEidtWithResult:(NSString *)result andIndexPath:(NSIndexPath *)indexPath;

@end

@interface HXInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) NSIndexPath *currIndexPath;
@property (nonatomic, weak) id<HXInfoTableViewCellDelegate>delegate;
@end
