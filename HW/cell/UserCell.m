//
//  UserCell.m
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "UserCell.h"
#import "HWDefine.h"

@interface UserCell ()

@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *userName;

@end

@implementation UserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initView];
    }
    return self;
}

- (void)initView {
    CGRect rec = self.frame;
    rec.size.width = HW_SCREEN_WIDTH;
    self.frame = rec;
    
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, HWR(10), HWR(60), HWR(60))];
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.layer.cornerRadius = HWR(30);
    _avatar.clipsToBounds = YES;
    _avatar.center = CGPointMake(HW_SCREEN_WIDTH/2, _avatar.center.y);
    [self.contentView addSubview:_avatar];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0, HWR(70), HW_SCREEN_WIDTH, HWR(30))];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:_userName];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, HWR(100), HW_SCREEN_WIDTH, HWR(3))];
    line.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:line];
}

- (void)setAvatar:(NSString *)avatar name:(NSString *)userName {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:avatar]];
    _userName.text = userName;
}

+ (CGFloat)getUserCellHeight {
    return HWR(103);
}

@end
