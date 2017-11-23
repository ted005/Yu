//
//  SecondViewController.m
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "SecondViewController.h"
#import "HWTableViewCell.h"
#import "HWDefine.h"
#import <SafariServices/SafariServices.h>

#import <AFNetworking/AFNetworking.h>

@interface SecondViewController ()

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, HW_SCREEN_WIDTH, 40)];
    titleView.text = @"最新主题";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.font = [UIFont boldSystemFontOfSize:20];
    titleView.textColor = [UIColor blackColor];
    [self.view addSubview:titleView];
    
    //渐变
    UIView *_gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y + titleView.frame.size.height, HW_SCREEN_WIDTH, HWR(3))];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.frame = _gradientView.bounds;
    [_gradientView.layer addSublayer:gradientLayer];
    [self.view addSubview:_gradientView];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(HW_SCREEN_WIDTH - HWR(35), 0, HWR(20), HWR(20));
    refreshBtn.center = CGPointMake(refreshBtn.center.x, titleView.center.y);
    [refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    
    CGFloat tableHeight = self.view.frame.size.height - 44 - titleView.frame.size.height - 50;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleView.frame.origin.y + titleView.frame.size.height + _gradientView.frame.size.height, HW_SCREEN_WIDTH, tableHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    self.title = @"最新主题";
    
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
    [manager GET:@"https://www.v2ex.com/api/topics/latest.json"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [weakSelf pushDataToDataSourceArr:(NSArray *)responseObject];
             [weakSelf.tableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             weakSelf.dataSourceArr = nil;
         }];
}

- (void)pushDataToDataSourceArr:(NSArray *)responseObject {
    for (NSDictionary *dic in responseObject) {
        PostModel *model = [[PostModel alloc] init];
        model.postTitle = dic[@"title"];
        model.jumpUrl = dic[@"url"];
        
        NSDictionary *memberDic = dic[@"member"];
        NSDictionary *nodeDic = dic[@"node"];
        
        model.userName = memberDic[@"username"];
        model.userAvatar = [NSString stringWithFormat:@"https:%@", memberDic[@"avatar_large"]];
        
        model.belongToNodeTitle = nodeDic[@"title"];
        model.belongToNodeUrl = nodeDic[@"url"];
        
        [_dataSourceArr addObject:model];
    }
}

- (void)refresh {
    _dataSourceArr = [[NSMutableArray alloc] init];
    [self sendService];
}

- (void)goToUser:(NSInteger)index {
    PostModel *model = _dataSourceArr[index];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.v2ex.com/member/%@", model.userName]];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    [self showViewController:safariVC sender:nil];
}

- (void)goToNode:(NSInteger)index {
    PostModel *model = _dataSourceArr[index];
    NSURL *url = [NSURL URLWithString:model.belongToNodeUrl];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    [self showViewController:safariVC sender:nil];
}

- (void)goToPost:(NSInteger)index {
    PostModel *model = _dataSourceArr[index];
    NSURL *url = [NSURL URLWithString:model.jumpUrl];
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    [self showViewController:safariVC sender:nil];
}



@end
