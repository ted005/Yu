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
        _postTitle = @"";
        _jumpUrl = @"";
        _userName = @"";
        _userAvatar = @"";
        _belongToNodeTitle = @"";
        _belongToNodeUrl = @"";
    }
    return self;
}

@end
