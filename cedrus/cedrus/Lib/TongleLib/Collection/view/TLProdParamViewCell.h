//
//  TLProdParamViewCell.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdParamsterList.h"

@interface TLProdParamViewCell : UITableViewCell

@property (nonatomic,strong) TLProdParamsterList *prodParamsterList;
@property (nonatomic,assign,readonly) CGFloat height;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
