//
//  ScrollNewsCellTableViewCell.h
//  ZNews
//
//  Created by wei zhao on 2017/8/27.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADScrollView.h"
@interface ScrollNewsCellTableViewCell : UITableViewCell<ADScrollViewViewDelegate>
@property (strong ,nonatomic) NSArray *arr;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier andImageArray:(NSArray*)arr;
@end
