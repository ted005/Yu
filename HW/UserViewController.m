//
//  UserViewController.m
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "UserViewController.h"
#import "HWDefine.h"
#import "HWUtil.h"
#import "UserCell.h"
#import "UserPostCell.h"
#import "HWTableViewCell.h"
#import "PostDetailViewControllerTableViewController.h"

#import <AFNetworking/AFNetworking.h>

@interface UserViewController ()

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"用户主题";
    
    [self sendUserService];
}

- (void)sendUserService {
    WS(weakSelf);
    _dataSourceArr = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.validatesDomainName = NO;
    
    [manager GET:[NSString stringWithFormat:@"https://www.v2ex.com/api/topics/show.json?username=%@", self.userName]
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [weakSelf pushDataToDataSourceArr:(NSArray *)responseObject];
             [weakSelf.tableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         }];
}

- (void)pushDataToDataSourceArr:(NSArray *)responseObject {
    [HWUtil pushDataToDataSourceArr:responseObject dataSource:_dataSourceArr];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [UserCell getUserCellHeight];
    }
    return [UserPostCell getCellHeight:[_dataSourceArr objectAtIndex:indexPath.row - 1]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *identifier = @"HWUserCellIdentifier";
        UserCell *cell = (UserCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setAvatar:self.userAvatar name:self.userName];
        return cell;
    }
    NSString *identifier2 = @"HWUserPostCellIdentifier";
    UserPostCell *cell = (UserPostCell *)[tableView dequeueReusableCellWithIdentifier:identifier2];
    if (!cell) {
        cell = [[UserPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:[_dataSourceArr objectAtIndex:indexPath.row - 1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    PostModel *model = _dataSourceArr[indexPath.row - 1];
    PostDetailViewControllerTableViewController *postVC = [[PostDetailViewControllerTableViewController alloc] init];
    postVC.model = model;
    [self.navigationController pushViewController:postVC animated:YES];
}

@end
