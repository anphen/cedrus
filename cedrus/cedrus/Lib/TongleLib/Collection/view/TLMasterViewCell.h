//
//  TLMasterViewCell.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMasterParam;
@interface TLMasterViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *user_head_photo_url;

@property (weak, nonatomic) IBOutlet UILabel    *user_nick_name;


@property (weak, nonatomic) IBOutlet UILabel    *latest_post_info;

@property (weak, nonatomic) IBOutlet UILabel    *post_update_time;

@property (weak, nonatomic) IBOutlet UIView     *count;


@property (nonatomic,strong) TLMasterParam *masterparam;
/**
 *  返回达人的tableViewCell
 *
 *  @param table 达人页面的tableView
 *
 *  @return 返回达人的tableViewCell
 */
+(instancetype)cellWithTableView:(UITableView *)table;

@end
