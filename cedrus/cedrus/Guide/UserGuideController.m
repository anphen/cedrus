//
//  UserGuideController.m
//  vTurning
//
//  Created by AppVV on 7/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserGuideController.h"
#import "AppDelegate.h"
#import <View+MASAdditions.h>
#import "UIColor+extend.h"

#define kNumberOfPages 3

NSString * const FIRST_LAUNCH = @"FirstLaunch";

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define kPageHeight [[UIScreen mainScreen] bounds].size.height//IS_IPHONE_5 ? 568.0f : 480.0f
#define kPageWidth  [[UIScreen mainScreen] bounds].size.width

@interface UserGuideController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *skipButton;

@end

@implementation UserGuideController

- (UIPageControl *) pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 30 )];
        _pageControl.pageIndicatorTintColor = [UIColor getColor:@"cdcdcd"];
        _pageControl.currentPageIndicatorTintColor = [UIColor getColor:@"ff5e00"];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, kPageWidth, kPageHeight);
        _scrollView.contentSize = CGSizeMake(kPageWidth * kNumberOfPages, kPageHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [_scrollView setBackgroundColor:[UIColor darkGrayColor]];
        _scrollView.showsHorizontalScrollIndicator = NO;
        NSArray *imageNames = @[@"guide1", @"guide2", @"guide3"];
        UIImageView *guideImage;
        CGRect imageFrame;
        for (int photoIndex = 0 ; photoIndex < kNumberOfPages ; photoIndex++)
        {
            imageFrame = CGRectMake(photoIndex * kPageWidth, 0.0f, kPageWidth, kPageHeight);
            guideImage = [[UIImageView alloc] initWithFrame: imageFrame];
            guideImage.image = [UIImage imageNamed:[imageNames objectAtIndex:photoIndex]];
            [_scrollView addSubview: guideImage];
        }
    }
    return _scrollView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:[self scrollView]];
    [self.view addSubview:[self pageControl]];
    [self addStartButton];
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
    self.pageControl.numberOfPages = 3;
    if (self.isSettingPage) {
        [self.view addSubview:self.skipButton];
        [self addSkipButton];
    } 
}

- (void) addSkipButton {
    __block typeof(self) blockSelf = self;
    [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(blockSelf.view.mas_right).offset(-10);
        make.top.equalTo(blockSelf.view.mas_top);
    }];
}

- (void) addStartButton {
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake( kPageWidth * (kNumberOfPages - 1) + (kPageWidth - 220)/2, kScreenHeight - 100, 220 , 42);
    [startButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [startButton setTitle:@"点击屏幕任意位置进入" forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"enter_normal"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"enter_hilighted"] forState:UIControlStateHighlighted];
    [startButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:startButton];
}

- (void) tapGesture:(UIGestureRecognizer *) recognizer {
    if (self.pageControl.currentPage == 2) {
        [self startButtonClicked:nil];
    }
}

- (void)startButtonClicked:(id)sender
{
    [self.view removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:FIRST_LAUNCH];
    [[NSNotificationCenter defaultCenter] postNotificationName:FIRST_LAUNCH object:nil];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate dismissGuideView];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    NSUInteger index = (NSUInteger) ([aScrollView contentOffset].x / kScreenWidth );
    self.pageControl.currentPage = index;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
