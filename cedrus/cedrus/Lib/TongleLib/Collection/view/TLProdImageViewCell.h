//
//  TLProdImageViewCell.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdImageDetails.h"

@class TLProdImageViewCell;

@protocol TLProdImageViewCellDelegate <NSObject>

-(void)prodImageViewCell:(TLProdImageViewCell *)prodImageViewCell;

@end


@interface TLProdImageViewCell : UITableViewCell

@property (nonatomic,strong)    TLProdImageDetails  *prodImageDetails;
//帖子图片
@property (nonatomic,weak)      UIImageView         *pic;
//帖子图片说明
@property (nonatomic,weak)      UILabel             *pic_memo;

@property (nonatomic,assign,readonly) CGFloat       height;

@property (nonatomic,assign) id<TLProdImageViewCellDelegate> delegate;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
