//
//  PostDetailViewControllerTableViewController.m
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "PostDetailViewControllerTableViewController.h"
#import "HWDefine.h"
#import "PostReplyModel.h"
#import "PostDetailUserCell.h"
#import "PostDetailReplyCell.h"
#import "UserViewController.h"

#import <AFNetworking/AFNetworking.h>

@interface PostDetailViewControllerTableViewController ()

@property(nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation PostDetailViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.model.userName;
    
    [self sendReplyService];
}

- (void)sendReplyService {
    WS(weakSelf);
    _dataSourceArr = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.validatesDomainName = NO;
    
    [manager GET:[NSString stringWithFormat:@"https://www.v2ex.com/api/replies/show.json?topic_id=%d", self.model.postId]
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
    for (NSDictionary *dic in responseObject) {
        PostReplyModel *model = [[PostReplyModel alloc] init];
        model.content = dic[@"content"];
        model.replyTime = dic[@"created"];
        
        NSDictionary *memberDic = dic[@"member"];
        model.userName = memberDic[@"username"];
        model.avatar = [NSString stringWithFormat:@"https:%@", memberDic[@"avatar_large"]];
        [_dataSourceArr addObject:model];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [PostDetailUserCell getCellHeight:_model];
    }
    return [PostDetailReplyCell getCellHeight:[_dataSourceArr objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *identifier = @"PostDetailUserCellIdentifier";
        PostDetailUserCell *cell = (PostDetailUserCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[PostDetailUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setData:_model];
        return cell;
    }
    NSString *identifier = @"PostDetailReplyCellIdentifier";
    PostDetailReplyCell *cell = (PostDetailReplyCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PostDetailReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    [cell setData:[_dataSourceArr objectAtIndex:indexPath.row] index:indexPath.row];
    return cell;
}

- (void)goToUser:(NSInteger)index {
    PostReplyModel *model = _dataSourceArr[index];
    UserViewController *userVC = [[UserViewController alloc] init];
    userVC.userAvatar = model.avatar;
    userVC.userName = model.userName;
    [self.navigationController pushViewController:userVC animated:YES];
}

@end
