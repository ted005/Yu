//
//  UserCell.h
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImage.h>

@interface UserCell : UITableViewCell

+ (CGFloat)getUserCellHeight;

- (void)setAvatar:(NSString *)avatar name:(NSString *)userName;
@end
