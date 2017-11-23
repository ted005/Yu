//
//  PostModel.h
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property(nonatomic, copy) NSString *postTitle;
@property(nonatomic, copy) NSString *jumpUrl;

@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *userAvatar;

//所属板块
@property(nonatomic, copy) NSString *belongToNodeTitle;
@property(nonatomic, copy) NSString *belongToNodeUrl;

@end
