//
//  SecondViewController.h
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWTableViewCell.h"

@interface SecondViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, HWTableViewCellDelegate>

- (void)pushDataToDataSourceArr:(NSArray *)responseObject;
@end

