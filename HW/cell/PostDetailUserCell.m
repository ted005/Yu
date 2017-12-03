//
//  PostDetailUserCell.m
//  HW
//
//  Created by hope on 2017/11/26.
//  Copyright © 2017年 Wei Wei. All rights reserved.
//

#import "PostDetailUserCell.h"
#import <SDWebImage/SDWebImage.h>

@interface PostDetailUserCell ()

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UILabel *content;
@property(nonatomic, strong) UIView *line2;

@end

@implementation PostDetailUserCell

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
    
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(HW_SCREEN_WIDTH - HWR(60) - HWR(10), HWR(10), HWR(60), HWR(60))];
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.layer.cornerRadius = HWR(30);
    _avatar.clipsToBounds = YES;
    [self.contentView addSubview:_avatar];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(HWR(10), HWR(10), _avatar.frame.origin.x - HWR(10)*2, 0)];
    _title.textAlignment = NSTextAlignmentLeft;
    _title.numberOfLines = 0;
    _title.lineBreakMode = NSLineBreakByWordWrapping;
    _title.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_title];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HW_SCREEN_WIDTH, HWR(1))];
    _line.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_line];
    
    _content = [[UILabel alloc] initWithFrame:CGRectMake(HWR(10), 0, HW_SCREEN_WIDTH - HWR(10)*2, 0)];
    _content.textAlignment = NSTextAlignmentLeft;
    _content.lineBreakMode = NSLineBreakByWordWrapping;
    _content.numberOfLines = 0;
    _content.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_content];
    
    _line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HW_SCREEN_WIDTH, HWR(5))];
    _line2.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_line2];
}


+ (CGFloat)getCellHeight:(PostModel *)model {
    CGFloat height = HWR(10);
    
    CGFloat titleHeight = ceilf([model.postTitle boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(90), MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}
                                                              context:nil].size.height);
    height += titleHeight + HWR(10);
    
    height = height < HWR(80) ? HWR(80): height;
    
    height += HWR(1);
    
    height += HWR(10);
    
    CGFloat contentHeight = ceilf([model.postContent boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(10)*2, MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                                                  context:nil].size.height);
    
    height += contentHeight + HWR(10);
    
    height += HWR(5);
    
    return height;
}
- (void)setData:(PostModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.userAvatar]];
    
    CGFloat titleHeight = ceilf([model.postTitle boundingRectWithSize:CGSizeMake(_title.frame.size.width, MAXFLOAT)
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}
                                                             context:nil].size.height);
    _title.text = model.postTitle;
    _title.frame = CGRectMake(_title.frame.origin.x, _title.frame.origin.y, _title.frame.size.width, titleHeight);
    
    CGFloat lineYOffset = _title.frame.origin.y + HWR(10) + titleHeight < HWR(80) ? HWR(80): _title.frame.origin.y + HWR(10) + titleHeight;
    
    _line.frame = CGRectMake(0, lineYOffset, HW_SCREEN_WIDTH, HWR(1));
    
    if (model.postContent.length == 0 || model.postContent == nil) {
        model.postContent = @"如题";
    }
    CGFloat contentHeight = ceilf([model.postContent boundingRectWithSize:CGSizeMake(HW_SCREEN_WIDTH - HWR(10)*2, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                                              context:nil].size.height);
    _content.text = model.postContent;
    _content.frame = CGRectMake(HWR(10), _line.frame.origin.y + HWR(10) + HWR(1), HW_SCREEN_WIDTH - HWR(10)*2, contentHeight);
    
    _line2.frame = CGRectMake(0, _content.frame.origin.y + HWR(10) + contentHeight, HW_SCREEN_WIDTH, HWR(5));
}


@end
