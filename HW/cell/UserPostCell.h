//
//  UserPostCell.h
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
#import "HWDefine.h"

@interface UserPostCell : UITableViewCell

+ (CGFloat)getCellHeight:(PostModel *)model;
- (void)setData:(PostModel *)model;

@end
