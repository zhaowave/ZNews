//
//  MeArticalFuncTableViewCell.m
//  ZNews
//
//  Created by wei zhao on 2017/7/2.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "MeArticalFuncTableViewCell.h"
#import "Masonry.h"
@implementation MeArticalFuncTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildView];
    }
    return self;
}

- (void) buildView {
    //订阅
    UIButton *subscribe = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:subscribe];
    [subscribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH/4 - 1);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self setTitleAndImageWithTitleName:@"订阅" andImgName:@"user_subscribe" inButton:subscribe];
    
    //收藏
    UIButton *collection = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:collection];
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subscribe.mas_right).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH/4 - 1);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self setTitleAndImageWithTitleName:@"收藏" andImgName:@"user_collection" inButton:collection];
    
    //跟帖
    UIButton *followPost = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:followPost];
    [followPost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(collection.mas_right).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH/4 - 1);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self setTitleAndImageWithTitleName:@"跟帖" andImgName:@"user_follow" inButton:followPost];
    
    //历史
    UIButton *history = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:history];
    [history mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(followPost.mas_right).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self setTitleAndImageWithTitleName:@"历史" andImgName:@"user_history" inButton:history];
    for (int i = 1; i<4; i++) {
        [self addVerticalLineInPositin:i andPartitionNumber:4];
    }
    
}

//设置按钮中图片和文字的位置为上下结构
- (void) setButtonLayout:(UIButton*) button {
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    (CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.frame.size.height+10 ,-button.imageView.frame.size.width, 0.0,0.0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0-30, 0, 0, -button.titleLabel.frame.size.width)];
}
//设置按钮的图片和文字
- (void) setTitleAndImageWithTitleName:(NSString*)name andImgName:(NSString*)imgName inButton:(UIButton*)button{
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:THIRD_PARTY_LOGIN_TEXT_SIZE],NSForegroundColorAttributeName:LIGHTGRAYCOLOR}] forState:UIControlStateNormal];
    
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:THIRD_PARTY_LOGIN_TEXT_SIZE],NSForegroundColorAttributeName:[UIColor redColor]}] forState:UIControlStateHighlighted];
    [self setButtonLayout:button];
}
//增加按钮间的垂直分割线
- (void) addVerticalLineInPositin:(int) position andPartitionNumber:(int) num {
    UIImageView *verticalSeprator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vertical_seprator"]];
    [self addSubview:verticalSeprator];
    [verticalSeprator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(position*SCREEN_WIDTH/num-1);
        make.width.mas_equalTo(1);
    }];
    verticalSeprator.backgroundColor = WHITECOLOR;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) buttonClicked:(UIButton*)btn{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
