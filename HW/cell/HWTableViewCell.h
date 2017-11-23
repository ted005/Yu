//
//  HWTableViewCell.h
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
#import <SDWebImage/SDWebImage.h>

@protocol HWTableViewCellDelegate

- (void)goToUser:(NSInteger)index;
- (void)goToNode:(NSInteger)index;

@end

@interface HWTableViewCell : UITableViewCell

@property(nonatomic, weak) id<HWTableViewCellDelegate> delegate;

+ (CGFloat)getCellHeight:(PostModel *)model;

- (void)setData:(PostModel *)model index:(NSInteger)index;

@end
