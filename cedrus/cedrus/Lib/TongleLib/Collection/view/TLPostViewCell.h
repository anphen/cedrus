//
//  TLPostViewCell.h
//  tongle
//
//  Created by liu on 15-4-25.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPostFrame,TLPostTopView;

@interface TLPostViewCell : UITableViewCell

@property (nonatomic,strong) TLPostFrame *postFrame;
@property (nonatomic,weak) TLPostTopView *topView;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
