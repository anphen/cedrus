//
//  TLShareView.h
//  tongle
//
//  Created by liu ruibin on 15-5-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TLShareViewDelegate <NSObject>

@optional

-(void)TLShareViewCanelButton;

@end

@interface TLShareView : UIView
@property (nonatomic,assign,readonly) CGFloat       height;
@property (nonatomic,weak) id<TLShareViewDelegate>  delegate;
@property (nonatomic,copy) NSString                 *parent_post_id;
@property (nonatomic,copy) NSString                 *product_id;
@property (nonatomic,copy) NSString                 *type_post_prod;
@property (nonatomic,copy) NSString                 *prod_relation_id;
@property (nonatomic,copy) NSString                 *title;

+(instancetype)share;

@end
