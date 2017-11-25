//
//  UserPostCell.m
//  HW
//
//  Created by hope on 2017/11/25.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "UserPostCell.h"

@interface UserPostCell()

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *subTitle;
@property(nonatomic, strong) UILabel *replies;

@end

@implementation UserPostCell

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
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(HWR(10), HWR(15), 0, 0)];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.numberOfLines = 0;
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_title];
    
    _replies = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, HWR(24))];
    _replies.backgroundColor = [UIColor blackColor];
    _replies.layer.cornerRadius = HWR(12);
    _replies.layer.masksToBounds = YES;
    _replies.textAlignment = NSTextAlignmentCenter;
    _replies.font = [UIFont systemFontOfSize:15];
    _replies.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_replies];
}

- (void)setData:(PostModel *)model {
    CGFloat replyWidth = ceilf([@(model.replies).stringValue boundingRectWithSize:CGSizeMake(MAXFLOAT, HWR(24))
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                                          context:nil].size.width) + HWR(10);
    replyWidth = replyWidth < HWR(24) ? HWR(24): replyWidth;
    _replies.frame = CGRectMake(HW_SCREEN_WIDTH - HWR(10)*2 - replyWidth, 0, replyWidth, HWR(24));
    _replies.center = CGPointMake(_replies.center.x, [self.class getCellHeight:model]/2.f);
    _replies.text = @(model.replies).stringValue;
    
    CGFloat titleHeight = ceilf([model.postTitle boundingRectWithSize:CGSizeMake(_replies.frame.origin.x - HWR(10)*2, MAXFLOAT)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}
                                                                          context:nil].size.height);
    _title.frame = CGRectMake(HWR(10), HWR(15), _replies.frame.origin.x - HWR(10)*2, titleHeight);
    _title.text = model.postTitle;
    
}

+ (CGFloat)getCellHeight:(PostModel *)model {
    CGFloat replyWidth = ceilf([@(model.replies).stringValue boundingRectWithSize:CGSizeMake(MAXFLOAT, HWR(24))
                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                                          context:nil].size.width) + HWR(10);
    replyWidth = replyWidth < HWR(24) ? HWR(24): replyWidth;
    CGFloat titleHeight = ceilf([model.postTitle boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(10)*2 - replyWidth - HWR(10)*2, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}
                                                              context:nil].size.height);
    return HWR(15)*2 + titleHeight;
}


@end
