//
//  CustomErrorView.m
//  bang5maiWap
//
//  Created by boguang on 15/4/22.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "CustomErrorView.h"
#import "UIImage+extend.h"
#import "UIImage+tintedImage.h"
#import "UIColor+extend.h"

@interface CustomErrorView()
@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UIButton  *retryButton;
@property (nonatomic, assign) UIView    *parentView;
@property (nonatomic, strong) UIImageView *logoImageView;

@end

@implementation CustomErrorView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.tipLabel];
        [self addSubview:self.retryButton];
        [self addSubview:self.logoImageView];
        [self createUI];
    }
    return self;
}

- (void) createUI {
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self).offset(128);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoImageView.mas_right).offset(20);
        make.top.equalTo(self).offset(185);
    }];
    
    [_retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImageView.mas_bottom).offset(40);
        make.centerX.equalTo(self);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
    }];
    
}

- (UIImageView *) logoImageView {
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"networkErrorLogo"];
    }
    return _logoImageView;
}

- (UILabel *) tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y-64-50-22, self.bounds.size.width, 40)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"亲，网络不给力哦~";
        _tipLabel.textColor = kBlackColor;
        _tipLabel.backgroundColor = kClearColor;
    }
    return _tipLabel;
}

- (UIButton *) retryButton {
    if (!_retryButton) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _retryButton.frame = CGRectMake(self.center.x - 60, self.center.y-64-22, 120, 40);
        _retryButton.backgroundColor = kClearColor;
        _retryButton.layer.cornerRadius = 3;
        _retryButton.layer.masksToBounds = YES;
        [_retryButton setTitle:@" 点击刷新" forState:UIControlStateNormal];
        [_retryButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_retryButton setBackgroundImage:[UIImage imageWithColor:[UIColor getColor:@"E53965"]
                                                            size:CGSizeMake(10, 10)]
                                                        forState:UIControlStateNormal];
      
        UIImageView *refreshImageView = [UIImageView new];
        refreshImageView.image = [UIImage imageNamed:@"networkErrorRegresh"];
        [_retryButton addSubview:refreshImageView];
        
        [refreshImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_retryButton).offset(14);
            make.top.equalTo(_retryButton).offset(12);
            make.width.equalTo(@17);
            make.height.equalTo(@17);
        }];
        [_retryButton addTarget:self action:@selector(retryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

- (IBAction)retryButtonAction:(id)sender {
    [self disappear];
    if (self.block) {
        self.block();
    }
}


#pragma mark ==
#pragma mark == public

- (id) parentView:(UIView *) view {
    assert(view);
    self.parentView = view;
    return self;
}

- (id) appear {
    [self.parentView addSubview:self];
    return self;
}

- (id) appearWithTitle:(NSString *) title {
    self.tipLabel.text = title;
    return [self appear];
}

- (id) disappear {
    [self removeFromSuperview];
    return self;
}

- (BOOL) isAppear {
    return self.superview ? YES: NO ;
}

@end
