//
//  TLProdMegViewCell.h
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdDetails.h"

@class TLProdMeg;

@interface TLProdMegViewCell : UITableViewCell

@property (nonatomic,strong) TLProdDetails *prodDetails;

@property (nonatomic,weak) TLProdMeg *prodMegView;


+(instancetype)cellWithTableCell:(UITableView *)tableview;
@end
