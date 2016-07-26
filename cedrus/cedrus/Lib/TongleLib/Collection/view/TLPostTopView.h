//
//  TLPostTopView.h
//  tongle
//
//  Created by liu on 15-4-27.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPostFrame,TLPostTopView;


@protocol TLPostTopViewDelegate <NSObject>
@optional

-(void)postTopViewHeadImage:(TLPostTopView *)postTopView WithPostFrame:(TLPostFrame *)postframe;

@end


@interface TLPostTopView : UIImageView

@property (nonatomic,strong) TLPostFrame *postframe;

@property (nonatomic,assign)id<TLPostTopViewDelegate>delegate;

@end
