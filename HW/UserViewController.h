//
//  UserViewController.h
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *userAvatar;

@end
