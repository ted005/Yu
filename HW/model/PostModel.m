//
//  PostModel.m
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

-(id)init{
    self = [super init];
    if(self){
        _postId = 0;
        _postTitle = @"";
        _postContent = @"";
        _jumpUrl = @"";
        _userName = @"";
        _userAvatar = @"";
        _belongToNodeTitle = @"";
        _belongToNodeUrl = @"";
        _replies = 0;
    }
    return self;
}

@end
