//
//  TLNavigationBar.h
//  tongle
//
//  Created by jixiaofei-mac on 15-5-26.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLNavigationBarDelegate <NSObject>

@optional

-(void)tlNavigationBarBack;

@end

@interface TLNavigationBar : UINavigationBar

@property (nonatomic,weak) UIButton *leftButton;
@property (nonatomic,weak) UILabel *titleCenter;
@property (nonatomic,weak) UIButton *rightOneButton;
@property (nonatomic,weak) UIButton *rightTwoButton;
@property (nonatomic,weak) UIView *rightView;

@property (nonatomic,weak) id<TLNavigationBarDelegate> Delegate;

-(void)creatWithTitle:(NSString *)title;

-(void)creatWithLeftButtonAndtitle:(NSString *)title;

-(void)creatWithLeftAndRightButtonAndtitle:(NSString *)title  collectBool:(int)collectBool;

-(void)creatWithLeftButtonAndtitle:(NSString *)title barButton:(UIBarButtonItem *)barButtonItem;

-(void)setCenterTitle:(NSString *)title;
@end
