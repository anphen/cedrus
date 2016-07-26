//
//  TLVermicelliViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-26.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLVermicelliViewCell.h"
#import "TLMasterParam.h"
#import "TLBadge.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+TL.h"
#import "TLImageName.h"
#import "UIImageView+Image.h"

@interface TLVermicelliViewCell ()

@property (nonatomic,strong) TLBadge *badge;

@end

@implementation TLVermicelliViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.addbtn.layer setMasksToBounds:YES];
    [self.addbtn.layer setCornerRadius:2.0]; //设置矩圆角半径
    [self.addbtn.layer setBorderWidth:1.0];   //边框宽度
    CGColorRef colorref2 = [UIColor getColor:@"72c6f7"].CGColor;
    [self.addbtn.layer setBorderColor:colorref2];//边框颜色
}

+(instancetype)cellWithTableView:(UITableView *)table
{
    /**
     *  设置缓存池中cell的标识
     */
    static NSString *ID = @"vermicelli";
    /**
     *  去缓存池中取cell
     */
    TLVermicelliViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        /**
         第一次要自己创建
         */
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLVermicelliViewCell" owner:self options:nil] lastObject];
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
    
    [self.headImage setImageWithURL:masterparam.user_head_photo_url placeImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]];
    self.headImage.layer.cornerRadius = 8;
    self.headImage.layer.masksToBounds = YES;
    
    
    
    self.name.text = masterparam.user_nick_name;
    self.comment.text = masterparam.latest_post_info;
    
    self.badge.frame = self.number.bounds;
    self.badge.value = [self comparisonWithString:masterparam.latest_post_count];
    [self.number addSubview:self.badge];
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



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addbtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addVermicelliView:withBtn:)]) {
        [self.delegate addVermicelliView:self withBtn:sender];
    }
}
@end
