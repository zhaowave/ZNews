//
//  NewsCell.h
//  ZNews
//
//  Created by wei zhao on 2017/7/6.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property (strong, nonatomic) UILabel *newsTitle;//标题
@property (strong, nonatomic) UIImageView *thumbNail;//图片
@property (strong, nonatomic) UILabel *newsSource;//新闻来源
@property (strong, nonatomic) UIImageView *moreAction;//更多三个点  ...

@end
