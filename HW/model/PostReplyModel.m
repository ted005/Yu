//
//  PostReplyModel.m
//  HW
//
//  Created by hope on 2017/11/26.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "PostReplyModel.h"

@implementation PostReplyModel

-(id)init{
    self = [super init];
    if(self){
        _avatar = @"";
        _userName = @"";
        _content = @"";
        _replyTime = @"";
    }
    return self;
}

@end
