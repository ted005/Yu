//
//  PostDetailUserCell.h
//  HW
//
//  Created by hope on 2017/11/26.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWDefine.h"
#import "PostModel.h"

@interface PostDetailUserCell : UITableViewCell

+ (CGFloat)getCellHeight:(PostModel *)model;
- (void)setData:(PostModel *)model;

@end
