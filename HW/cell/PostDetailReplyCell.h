//
//  PostDetailReplyCell.h
//  HW
//
//  Created by hope on 2017/11/26.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReplyModel.h"
#import "HWDefine.h"

#import <SDWebImage/SDWebImage.h>

@protocol PostDetailReplyCellDelegate

- (void)goToUser:(NSInteger)index;

@end

@interface PostDetailReplyCell : UITableViewCell

@property(nonatomic, weak) id<PostDetailReplyCellDelegate> delegate;

+ (CGFloat)getCellHeight:(PostReplyModel *)model;
- (void)setData:(PostReplyModel *)model index:(NSInteger)index;

@end
