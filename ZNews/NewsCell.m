//
//  NewsCell.m
//  ZNews
//
//  Created by wei zhao on 2017/7/6.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsCell.h"

#define kGap 10
@interface NewsCell()



@end

@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createViews];
    }
    return self;
}
/**
 创建cell上的元素
 */
- (void) createViews {
    self.thumbNail = [[UIImageView alloc] init];
    [self addSubview:self.thumbNail];
    [self.thumbNail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kGap);
        make.top.equalTo(self.mas_top).offset(kGap);
        make.bottom.equalTo(self.mas_bottom).offset(-kGap);
        make.width.mas_equalTo(120);
    }];
    //self.thumbNail.backgroundColor = CUSTOMER_RED;
    
    self.newsTitle = [UILabel new];
    self.newsSource.font = [UIFont systemFontOfSize:13];
    self.newsTitle.numberOfLines = 0;
    
    [self addSubview:self.newsTitle];
    [self.newsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.thumbNail.mas_left).offset(-20);
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.thumbNail.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    
    self.newsSource = [UILabel new];
    self.newsSource.font = [UIFont systemFontOfSize:9];
    //self.newsSource.backgroundColor = LIGHTGRAYCOLOR;
    [self addSubview:self.newsSource];
    [self.newsSource mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsTitle.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(12);
    }];
    //self.newsSource.layer.cornerRadius = 2;
    
    self.moreAction = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news_more_info"]];
    [self addSubview:self.moreAction];
    [self.moreAction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.newsTitle.mas_right);
        make.height.mas_equalTo(self.newsSource.mas_height);
        make.bottom.equalTo(self.newsSource.mas_bottom);
        make.width.mas_equalTo(20);
    }];
    //[self.moreAction sizeToFit];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
