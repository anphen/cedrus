//
//  TLMasterViewCell.m
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMasterViewCell.h"
#import "TLMasterParam.h"
#import "TLBadge.h"
#import <QuartzCore/QuartzCore.h>
#import "TLImageName.h"
#import "UIImageView+Image.h"

@interface TLMasterViewCell ()
@property (nonatomic,strong) TLBadge *badge;

@end

@implementation TLMasterViewCell

- (void)awakeFromNib
{
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)table
{
    /**
     *  设置缓存池中cell的标识
     */
    static NSString *ID = @"master";
    /**
     *  去缓存池中取cell
     */
    TLMasterViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        /**
         第一次要自己创建
         */
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLMasterViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

/**
 *  给每个cell传递对象
 *
 *  @param masterparam 传入的对象
 */

-(TLBadge *)badge
{
    if (_badge == nil) {
        _badge = [[TLBadge alloc]init];
    }
    return _badge;
}


-(void)setMasterparam:(TLMasterParam *)masterparam
{
    _masterparam = masterparam;

    [self.user_head_photo_url setImageWithURL:masterparam.user_head_photo_url placeImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]];
    self.user_head_photo_url.layer.cornerRadius = 8;
    self.user_head_photo_url.layer.masksToBounds = YES;
 
    
    
    self.user_nick_name.text = masterparam.user_nick_name;
    self.latest_post_info.text = masterparam.latest_post_info;
    if (masterparam.post_update_time.length) {
        int length = (int)masterparam.post_update_time.length-10 ? 10 : (int)masterparam.post_update_time.length;
        self.post_update_time.text = [masterparam.post_update_time substringToIndex:length];
    }
    
    self.badge.frame = self.count.bounds;
    self.badge.value = [self comparisonWithString:masterparam.latest_post_count];
    [self.count addSubview:self.badge];
}


/**
 *  数据显示设置
 *
 *  @param number 实际数据
 *
 *  @return ui显示的数据
 */
-(NSString *)comparisonWithString:(NSString *)number
{
    NSString *maxNumber = @"99";
    NSString *result = nil;
    if ([number compare:maxNumber options:NSNumericSearch] == NSOrderedDescending) {
        result = @"99+";
    }else
    {
        result = number;
    }
    return result;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
