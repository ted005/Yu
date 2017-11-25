//
//  HWUtil.m
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "HWUtil.h"
#import "PostModel.h"

@implementation HWUtil

+ (void)pushDataToDataSourceArr:(NSArray *)responseObject dataSource:(NSMutableArray *)dataSourceArr {
    for (NSDictionary *dic in responseObject) {
        PostModel *model = [[PostModel alloc] init];
        model.postId = [dic[@"id"] intValue];
        model.postTitle = dic[@"title"];
        model.postContent = dic[@"content"];
        model.jumpUrl = dic[@"url"];
        
        NSDictionary *memberDic = dic[@"member"];
        NSDictionary *nodeDic = dic[@"node"];
        
        model.userName = memberDic[@"username"];
        model.userAvatar = [NSString stringWithFormat:@"https:%@", memberDic[@"avatar_large"]];
        
        model.belongToNodeTitle = nodeDic[@"title"];
        model.belongToNodeUrl = nodeDic[@"url"];
        model.replies = [dic[@"replies"] integerValue];
        
        [dataSourceArr addObject:model];
    }
}

@end
