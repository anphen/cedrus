//
//  TLProdDetailCommentCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-8-12.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdProductRatingList.h"

@interface TLProdDetailCommentCell : UITableViewCell

@property (nonatomic,strong)            TLProdProductRatingList *prodProductRatingList;
@property (nonatomic,assign,readonly)   CGFloat                 height;

@property (nonatomic,assign)            BOOL commentHide;

+(instancetype)cellWithTableCell:(UITableView *)tableview;

@end
