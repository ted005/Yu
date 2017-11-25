//
//  HWTableViewCell.m
//  HW
//
//  Created by Wei Wei on 2017/11/22.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "HWTableViewCell.h"
#import "HWDefine.h"

const static NSInteger NODE_BUTTON_TAG = 1000;
const static NSInteger NODE_AVATAR_TAG = 2000;

@interface HWTableViewCell()

@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *userName;
@property(nonatomic, strong) UILabel *content;
@property(nonatomic, strong) UIButton *belongToBtn;
@property(nonatomic, strong) UILabel *recent;

@end

@implementation HWTableViewCell

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
    
    UIView *sbgView = UIView.new;
    sbgView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = sbgView;
    
    CGFloat leftMargin = HWR(10);
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(leftMargin, leftMargin, HWR(60), HWR(60))];
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.layer.cornerRadius = HWR(8);
    _avatar.clipsToBounds = YES;
    _avatar.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUser:)];
    [_avatar addGestureRecognizer:gesture];
    [self.contentView addSubview:_avatar];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(2 *leftMargin + HWR(60), leftMargin, HW_SCREEN_WIDTH - HWR(80) - HWR(10), HWR(15))];
    _userName.textAlignment = NSTextAlignmentCenter;
//    _userName.backgroundColor = CTColorHex(0xefefef);
    _userName.font = [UIFont systemFontOfSize:17];
    _userName.layer.cornerRadius = HWR(8);
    [self.contentView addSubview:_userName];
    
    _belongToBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _belongToBtn.backgroundColor = [UIColor blackColor];//CTColorHex(0xefefef);CTColorHex(0x26AAF2)
    _belongToBtn.layer.cornerRadius = HWR(6);
    _belongToBtn.layer.masksToBounds = YES;
    _belongToBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _belongToBtn.frame = CGRectMake(0, leftMargin, 0, HWR(15));
    [_belongToBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_belongToBtn addTarget:self action:@selector(goToNode:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_belongToBtn];
    
    _content = [[UILabel alloc] initWithFrame:CGRectMake(HWR(80), leftMargin + HWR(15) + HWR(5), HW_SCREEN_WIDTH - HWR(80) - HWR(10), 0)];
    _content.textAlignment = NSTextAlignmentLeft;
    _content.numberOfLines = 0;
    _content.lineBreakMode = NSLineBreakByWordWrapping;
    _content.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_content];
    
    
}

- (void)goToUser:(UITapGestureRecognizer *)gesture {
    NSInteger index = gesture.view.tag - NODE_AVATAR_TAG;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(goToUser:)]) {
        [self.delegate goToUser:index];
//    }
}

- (void)goToNode:(UIButton *)button {
    NSInteger index = button.tag - NODE_BUTTON_TAG;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(goToNode:)]) {
        [self.delegate goToNode:index];
//    }
}

- (void)setData:(PostModel *)model index:(NSInteger)index {
    _belongToBtn.tag = NODE_BUTTON_TAG + index;
    _avatar.tag = NODE_AVATAR_TAG + index;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.userAvatar]];
    
    //user name
    CGFloat width = ceilf([model.userName boundingRectWithSize:CGSizeMake(MAXFLOAT, HWR(15))
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                                         context:nil].size.width);
    
    _userName.text = model.userName;
    _userName.frame = CGRectMake(_userName.frame.origin.x, _userName.frame.origin.y, width + HWR(8), _userName.frame.size.height);
    
    //node
    CGFloat width2 = ceilf([model.belongToNodeTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, HWR(15))
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                                       context:nil].size.width);
    
    [_belongToBtn setTitle:model.belongToNodeTitle forState:UIControlStateNormal];
    _belongToBtn.frame = CGRectMake(HW_SCREEN_WIDTH - HWR(10) - (width2 + HWR(8)), _belongToBtn.frame.origin.y, width2 + HWR(8), _belongToBtn.frame.size.height);
    
    
    //post tile
    _content.text = model.postTitle;
    CGFloat height = ceilf([model.postTitle boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(80) - HWR(10), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}
                                                  context:nil].size.height);
    _content.frame = CGRectMake(_content.frame.origin.x, _content.frame.origin.y, _content.frame.size.width, height);
}

+ (CGFloat)getCellHeight:(PostModel *)model {
    CGFloat height = HWR(10) * 2 + HWR(15) + HWR(5);
    height += ceilf([model.postTitle boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(80) - HWR(10), MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}
                                                  context:nil].size.height);
    
    
    return height < HWR(80) ? HWR(80): height;
}

@end
