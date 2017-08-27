//
//  ADScrollView.m
//  ZNews
//
//  Created by wei zhao on 2017/8/27.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ADScrollView.h"
#import "Masonry.h"
#import "MASConstraint.h"
#define DEFAULTTIME 3

@implementation ADScrollView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        _currImageView = [[UIImageView alloc] init];
        [_scrollView addSubview:_currImageView];
        _otherImageView = [[UIImageView alloc] init];
        [_scrollView addSubview:_otherImageView];
    }
    return _scrollView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width-100, self.bounds.size.height - 15, self.bounds.size.width/4, 15)];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

#pragma mark 设置图片数组
- (void)setImageArray:(NSArray *)imageArray{
    if (!imageArray.count) return;
    _imageArray = imageArray;
    _images = [NSMutableArray array];
    for (int i = 0; i < imageArray.count; i++) {
        if ([imageArray[i] isKindOfClass:[UIImage class]]) {
            [_images addObject:imageArray[i]];
        }
    }
    
    //防止在滚动过程中重新给imageArray赋值时报错
    if (_currIndex >= _images.count) _currIndex = _images.count - 1;
    self.currImageView.image = _images[_currIndex];
    self.pageControl.numberOfPages = _images.count;
    [self layoutSubviews];
}

- (instancetype)initWithImages:(NSArray *)imageArray withFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageArray = imageArray;
    }
    return self;
}

#pragma mark 设置scrollView的contentSize
- (void)setScrollViewContentSize {
    if (_images.count > 1) {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 5, 0);
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width * 2, 0);
        self.currImageView.frame = CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height);
        [self startTimer];
    } else {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
}
#pragma mark- --------定时器相关方法--------
- (void)startTimer {
    //如果只有一张图片，则直接返回，不开启定时器
    if (_images.count <= 1) return;
    //如果定时器已开启，先停止再重新开启
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:_time < 2? DEFAULTTIME: _time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 3, 0) animated:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //有导航控制器时，会默认在scrollview上方添加64的内边距，这里强制设置为0
    _scrollView.contentInset = UIEdgeInsetsZero;
    
    _scrollView.frame = self.bounds;
    [self setScrollViewContentSize];
}

#pragma mark 当图片滚动过半时就修改当前页码
- (void)changeCurrentPageWithOffset:(CGFloat)offsetX {
    if (offsetX < self.frame.size.width * 1.5) {
        NSInteger index = self.currIndex - 1;
        if (index < 0) index = self.images.count - 1;
        _pageControl.currentPage = index;
    } else if (offsetX > self.frame.size.width * 2.5){
        _pageControl.currentPage = (self.currIndex + 1) % self.images.count;
    } else {
        _pageControl.currentPage = self.currIndex;
    }
    if ([_delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [_delegate scrollToIndex:self.currIndex];
    }
}
#pragma mark- --------UIScrollViewDelegate--------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    [self changeCurrentPageWithOffset:offsetX];
    if (offsetX < self.frame.size.width * 2) {//right
        self.otherImageView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex < 0) self.nextIndex = _images.count - 1;
        if (offsetX <= self.frame.size.width) [self changeToNext];
    } else if (offsetX > self.frame.size.width * 2){//left
        self.otherImageView.frame = CGRectMake(CGRectGetMaxX(_currImageView.frame), 0, self.frame.size.width, self.frame.size.height);
        self.nextIndex = (self.currIndex + 1) % _images.count;
        if (offsetX >= self.frame.size.width * 3) [self changeToNext];
    }
    self.otherImageView.image = self.images[self.nextIndex];
}

- (void)changeToNext {
    self.currImageView.image = self.otherImageView.image;
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width * 2, 0);
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

#pragma protocol

- (void)handleTap:(UITapGestureRecognizer *)tap {
    [self stopTimer];
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:self.currIndex];
    }
    
}

@end

