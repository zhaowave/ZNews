//
//  ScrollNewsCellTableViewCell.m
//  ZNews
//
//  Created by wei zhao on 2017/8/27.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ScrollNewsCellTableViewCell.h"
#import "ADScrollView.h"
#import "NewsBasicInfo.h"

@implementation ScrollNewsCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier andImageArray:(NSArray*)arr{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _arr = arr;
        //[cell.thumbNail sd_setImageWithURL:[NSURL URLWithString:data.thumbnails[0]]];;
        
        [self createViews];
    }
    return self;
}

- (void) createViews{
    NSMutableArray *imageUrlArray = [NSMutableArray new];
    for (int i = 0; i<_arr.count; i++) {
        NewsBasicInfo *data = _arr[i];
        NSString *str= [NSString stringWithFormat:@"%@",data.thumbnails[0]];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        [imageUrlArray addObject:image];
        
    }
    if (imageUrlArray.count != 0) {
        ADScrollView *ADView = [[ADScrollView alloc] initWithImages:imageUrlArray withFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        ADView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        ADView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"e7240b"];
        [self.contentView addSubview:ADView];
        __weak typeof(self) weakSelf = self;
        ADView.delegate = self;
        ADView.time = 5.0;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)didClickPage:(ADScrollView *)view atIndex:(NSInteger)index {
    
    NSLog(@"clicked");
    NewsBasicInfo *data = _arr[index];
    //newsDetailVC.requestURLString = data.url;
    
    [ZNavigator navigateTo:@"NewsDetailViewController" withData:@{@"url":data.url,@"News":data,@"source":@"imagenews"}];
}

@end
