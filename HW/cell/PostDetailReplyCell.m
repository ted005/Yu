//
//  PostDetailReplyCell.m
//  HW
//
//  Created by hope on 2017/11/26.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "PostDetailReplyCell.h"

const static NSInteger NODE_AVATAR_TAG = 1000;

@interface PostDetailReplyCell()

@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *content;

@end

@implementation PostDetailReplyCell

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
    
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(HWR(10), 0, HWR(50), HWR(50))];
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.layer.cornerRadius = HWR(25);
    _avatar.clipsToBounds = YES;
    _avatar.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUser:)];
    [_avatar addGestureRecognizer:gesture];
    
    [self.contentView addSubview:_avatar];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(HWR(70), HWR(10), HW_SCREEN_WIDTH - HWR(70), HWR(20))];
    _userName.textAlignment = NSTextAlignmentLeft;
    _userName.font = [UIFont systemFontOfSize:20];
    _userName.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_userName];
    
    _content = [[UILabel alloc] initWithFrame:CGRectMake(HWR(70), HWR(30), HW_SCREEN_WIDTH - HWR(70) - HWR(10), 0)];
    _content.textAlignment = NSTextAlignmentLeft;
    _content.numberOfLines = 0;
    _content.lineBreakMode = NSLineBreakByWordWrapping;
    _content.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_content];
}

+ (CGFloat)getCellHeight:(PostReplyModel *)model {
    CGFloat height = HWR(10);
    
    height += HWR(20);
    height += HWR(10);
    
    CGFloat contentHeight = ceilf([model.content boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(70) - HWR(10), MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                              context:nil].size.height);
    height += contentHeight;
    height += HWR(10);
    height = height < HWR(80) ? HWR(80): height;
    
    return height;
}
- (void)setData:(PostReplyModel *)model index:(NSInteger)index {
    _avatar.center = CGPointMake(_avatar.center.x, [self.class getCellHeight:model]/2);
    _avatar.tag = NODE_AVATAR_TAG + index;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _userName.text = model.userName;
    
    CGFloat contentHeight = ceilf([model.content boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(70) - HWR(10), MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                                  context:nil].size.height);
    
    _content.frame = CGRectMake(HWR(70), HWR(30), HW_SCREEN_WIDTH - HWR(70) - HWR(10), contentHeight);
    _content.text = model.content;
}

- (void)goToUser:(UITapGestureRecognizer *)gesture {
    NSInteger index = gesture.view.tag - NODE_AVATAR_TAG;
    [self.delegate goToUser:index];
}

@end
