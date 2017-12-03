//
//  PostDetailViewControllerTableViewController.h
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
#import "PostDetailReplyCell.h"

@interface PostDetailViewControllerTableViewController : UITableViewController<PostDetailReplyCellDelegate>

@property(nonatomic, strong) PostModel *model;

@end
