//
//  NewsCell.m
//  ZNews
//
//  Created by wei zhao on 2017/7/6.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()

@property (strong, nonatomic) UILabel *newsTitle;//标题
@property (strong, nonatomic) UIImageView *thumbNail;//图片
@property (strong, nonatomic) UILabel *newsSource;//新闻来源
@property (strong, nonatomic) UILabel *moreAction;//更多三个点  ...

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
