//
//  FirstViewController.m
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "FirstViewController.h"
#import "HWTableViewCell.h"
#import "HWDefine.h"
#import "HWUtil.h"
#import "UserViewController.h"
#import "PostDetailViewControllerTableViewController.h"
#import <SafariServices/SafariServices.h>

#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface FirstViewController ()

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh"] style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    [self.navigationItem setRightBarButtonItem:refresh];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    self.title = @"今日热议";
    
    [self sendService];
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostModel *model = _dataSourceArr[indexPath.row];
    return [HWTableViewCell getCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"HWTableViewCellIdentifier";
    HWTableViewCell *cell = (HWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HWTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    PostModel *model = _dataSourceArr[indexPath.row];
    [cell setData:model index:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self goToPost:indexPath.row];
}

- (void)sendService {
    WS(weakSelf);
    _dataSourceArr = [[NSMutableArray alloc] init];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.validatesDomainName = NO;
    
    [manager GET:@"https://www.v2ex.com/api/topics/hot.json"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [weakSelf pushDataToDataSourceArr:(NSArray *)responseObject];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf.tableView reloadData];
                 [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
             });
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             weakSelf.dataSourceArr = nil;
             dispatch_async(dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
             });
         }];
}

- (void)pushDataToDataSourceArr:(NSArray *)responseObject {
    [HWUtil pushDataToDataSourceArr:responseObject dataSource:_dataSourceArr];
}

- (void)refresh {
    _dataSourceArr = [[NSMutableArray alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self performSelector:@selector(sendService) withObject:nil afterDelay:0.3];
//    [self sendService];
}

- (void)goToUser:(NSInteger)index {
    PostModel *model = _dataSourceArr[index];
    UserViewController *userVC = [[UserViewController alloc] init];
    userVC.userAvatar = model.userAvatar;
    userVC.userName = model.userName;
    [self.navigationController pushViewController:userVC animated:YES];
}

- (void)goToNode:(NSInteger)index {
    return;
    PostModel *model = _dataSourceArr[index];
    NSURL *url = [NSURL URLWithString:model.belongToNodeUrl];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    safariVC.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController.parentViewController showViewController:safariVC sender:nil];
}

- (void)goToPost:(NSInteger)index {
    PostModel *model = _dataSourceArr[index];
    PostDetailViewControllerTableViewController *postVC = [[PostDetailViewControllerTableViewController alloc] init];
    postVC.model = model;
    [self.navigationController pushViewController:postVC animated:YES];
}


@end
