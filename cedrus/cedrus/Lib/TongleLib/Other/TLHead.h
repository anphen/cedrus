//
//  TLHead.h
//  TL11
//
//  Created by liu on 15-4-20.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headDelegate <NSObject>

@optional

-(void)btnClickedWithbtn:(UIButton *)btn;

@end

@interface TLHead : UIView

@property (nonatomic,weak) UIImageView *navigationImageView;
@property (nonatomic,weak) UIScrollView *scroll;

@property (nonatomic,strong) id<headDelegate> delegate;

-(void)CreateNavigationBartitleArray:(NSArray *)titleArray Controller:(id)Controller;

-(void)btnClicked:(UIButton *)btn;

@end
