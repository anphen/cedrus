//
//  TLVermicelliViewCell.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-26.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMasterParam,TLVermicelliViewCell;


@protocol TLVermicelliViewCellDelegate <NSObject>

@optional

-(void)addVermicelliView:(TLVermicelliViewCell *)vermicelliViewCell withBtn:(UIButton *)btn;

@end


@interface TLVermicelliViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *comment;

@property (weak, nonatomic) IBOutlet UIButton *addbtn;

@property (weak, nonatomic) IBOutlet UIView *number;

@property (weak,nonatomic) id<TLVermicelliViewCellDelegate>delegate;

- (IBAction)addbtn:(UIButton *)sender;


@property (nonatomic,strong) TLMasterParam *masterparam;
/**
 *  返回粉丝的tableViewCell
 *
 *  @param table 粉丝页面的tableView
 *
 *  @return 返回粉丝的tableViewCell
 */
+(instancetype)cellWithTableView:(UITableView *)table;

@end
