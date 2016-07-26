//
//  TLProdCommentViewCell.h
//  tongle
//
//  Created by liu ruibin on 15-5-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdProductRatingList.h"

@interface TLProdCommentViewCell : UITableViewCell

@property (nonatomic,strong)            TLProdProductRatingList *prodProductRatingList;
@property (nonatomic,assign,readonly)   CGFloat                 height;

+(instancetype)cellWithTableCell:(UITableView *)tableview;
@end
