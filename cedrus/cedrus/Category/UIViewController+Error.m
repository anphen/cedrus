//
//  BaseViewController+Error.m
//  bang5mai
//
//  Created by y on 15/9/23.
//  Copyright © 2015年 xiaolang. All rights reserved.
//

#import "UIViewController+Error.h"
#import <objc/runtime.h>
#import "UIColor+extend.h"

#define kCenterX        self.view.center.x
#define kCenterY        self.view.center.y
#define heightHarf      [UIScreen mainScreen].bounds.size.height/2
static char ERROR_BLOCK_TAG;
static char ERROR_VIEW_TAG;

@interface UIViewController (__Error)
@property (nonatomic, copy) voidBlock   errorBlock;
@end

@implementation UIViewController (Error)
- (voidBlock) errorBlock{
    return objc_getAssociatedObject(self, &ERROR_BLOCK_TAG);
}

- (void) setErrorBlock:(voidBlock)errorBlock{
    objc_setAssociatedObject(self, &ERROR_BLOCK_TAG, errorBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) setErrorView:(UIView *)errorView {
    objc_setAssociatedObject(self, &ERROR_VIEW_TAG, errorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *) errorView {
    return objc_getAssociatedObject(self, &ERROR_VIEW_TAG);
}

- (UIView *) showErrorImage:(NSString *)imageName title:(NSString *)title tips:(NSString *)tips block:(voidBlock)block{
    self.errorBlock = block;
    if (!self.errorView) {
        self.errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        self.errorView .backgroundColor = kWhiteColor;
        //image
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kCenterX-40, heightHarf-200, 80, 80)];
        imageView.image = [UIImage imageNamed:imageName];
        [self.errorView addSubview:imageView];
        //title
        UILabel * _reasonLable = [[UILabel alloc] initWithFrame:CGRectMake(kCenterX-150/2, heightHarf-100, 150, 30)];
        _reasonLable.text = title;
        _reasonLable.textAlignment = NSTextAlignmentCenter;
        _reasonLable.font = [UIFont systemFontOfSize:16];
        _reasonLable.textColor = [UIColor blackColor];
        [self.errorView addSubview:_reasonLable];
        //tips
        UILabel * _messageLable = [[UILabel alloc] initWithFrame:CGRectMake(kCenterX-130/2, heightHarf-80, 130, 30)];
        _messageLable.text = tips;
        _messageLable.textAlignment = NSTextAlignmentCenter;
        _messageLable.font = [UIFont systemFontOfSize:14];
        _messageLable.textColor = [UIColor getColor:@"9A9A9A"];
        [self.errorView addSubview:_messageLable];
        //button
        UIButton * _refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(kCenterX-40, heightHarf-40, 80, 80 / 3)];
        [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"btn_error_detail_Normal"] forState:UIControlStateNormal];
        [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"btn_error_detail_selected"]  forState:UIControlStateSelected];
        [_refreshBtn addTarget:self action:@selector(__reloadAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.errorView addSubview:_refreshBtn];
    }
    [self.view addSubview:self.errorView];
    [self.view bringSubviewToFront:self.errorView];
    return self.errorView;
}

- (IBAction)__reloadAction:(id)sender{
    if (self.errorBlock) {
        self.errorBlock();
    }
}

- (id) hideErrorView{
    if (self.errorView) {
        [self.errorView removeFromSuperview];
        self.errorView = nil;
        self.errorBlock = nil;
    }
    return self;
}
@end
