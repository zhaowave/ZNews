//
//  ADScrollView.h
//  ZNews
//
//  Created by wei zhao on 2017/8/27.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADScrollViewViewDelegate;

@interface ADScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIImageView *currImageView;

@property (nonatomic, strong) UIImageView *otherImageView;

@property (nonatomic, assign) NSInteger currIndex;

@property (nonatomic, assign) NSInteger nextIndex;

@property (nonatomic, strong) NSTimer *timer;
/**
 *  轮播的图片数组，可以是本地图片（UIImage，不能是图片名称）
 */
@property (nonatomic, strong) NSArray *imageArray;
/**
 *  每一页停留时间，默认为5s，最少2s
 *  当设置的值小于2s时，则为默认值
 */
@property (nonatomic, assign) NSTimeInterval time;



@property (nonatomic,weak) id<ADScrollViewViewDelegate> delegate;
- (instancetype)initWithImages:(NSArray *)imageArray withFrame:(CGRect)frame;
- (void)startTimer;
- (void)stopTimer;
@end


@protocol ADScrollViewViewDelegate <NSObject>
@optional
- (void)didClickPage:(ADScrollView *)view atIndex:(NSInteger)index;
- (void)scrollToIndex:(NSInteger)index;

@end

