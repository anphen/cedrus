//
//  TLGroupCouponsListViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/17.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponsListViewCell.h"
#import "TLGroupCoupons.h"
#import "TLImageName.h"
#import "TLGroupDetailCoupon.h"
#import "UIImage+TL.h"
#import "UIColor+TL.h"

@interface TLGroupCouponsListViewCell ()

@property (nonatomic,weak) UIImageView *backgroundImageView;

@end



@implementation TLGroupCouponsListViewCell




+(instancetype)cellWithTableview:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TLGroupCouponsListViewCell";
    [tableview registerClass:self forCellReuseIdentifier:ID];
    TLGroupCouponsListViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
}


-(void)setGroupCoupons:(TLGroupCoupons *)groupCoupons
{
    _groupCoupons = groupCoupons;
}



-(void)setShowType:(NSString *)showType
{
    _showType = showType;
    [self setCellWithGroupCoupons:_groupCoupons andState:[showType integerValue]];
}

-(void)setCellWithGroupCoupons:(TLGroupCoupons *)groupCoupons andState:(NSInteger)integer{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    //+(UIImage *)resizedImage:(NSString *)name
    
    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.image = [UIImage resizedImage:TLCOUPON_BACKGROUND leftScale:0.8 topScale:0.8];
    [self.contentView addSubview:backgroundImageView];
    _backgroundImageView = backgroundImageView;
    
    CGFloat WIDTH = self.superview.bounds.size.width;
    
    UIView *headViewRule = [[UIView alloc]init];
    headViewRule.frame = CGRectMake(0, 0, WIDTH, 20);
    
    UIImageView * headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, WIDTH-20, 30)];
    
    if ([_groupCoupons.out_of_date integerValue]) {
         headView.image = [UIImage imageNamed:USED_REFUNDED_COUPON_TOP];
    }else
    {
        headView.image = [UIImage imageNamed:COUPON_TOP];
    }
    
    UILabel *storeName=[[UILabel alloc]init];
     storeName.font = [UIFont systemFontOfSize:14];
    storeName.textColor = [UIColor getColor:@"FFFFFF"];
    storeName.text= [NSString stringWithFormat:@"%@",groupCoupons.prod_name];
    CGSize storeNameSize = [ storeName.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    storeName.frame = CGRectMake(20, 0, storeNameSize.width, 30);
    [headView addSubview:storeName];
    
    
    UILabel *time=[[UILabel alloc]init];//
    time.text= [NSString stringWithFormat:@"%@-%@",groupCoupons.overdue_date_from,groupCoupons.overdue_date_to];
    time.textColor = [UIColor getColor:@"FFFFFF"];
    time.font = [UIFont systemFontOfSize:10];
     CGSize timeSize = [ time.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10]}];
    time.frame = CGRectMake(headView.bounds.size.width-10-timeSize.width, 0, timeSize.width, 30);
    [headView addSubview:time];
    [self.contentView addSubview:headView];
    
    
    NSArray *numbers= groupCoupons.coupon_code_list;
    switch (integer) {
        case 0://不需要展开
        {
            for (int i=0; i<numbers.count; i++) {
                [self creatViewWithNumber:numbers[i] andID:i andNumberCount:(int)numbers.count];
            }
        }
            break;
        case 1:
        {
            [self creatViewWithNumber:numbers[0] andID:0 andNumberCount:(int)numbers.count];
            [self creatViewWithNumber:numbers[1] andID:1 andNumberCount:(int)numbers.count];
            [self creatBottomViewWithViewNumber:2 andNumberCount:(int)numbers.count];
        }
            break;
        case 2:
        {
            for (int i=0; i<numbers.count; i++) {
                [self creatViewWithNumber:numbers[i] andID:i andNumberCount:(int)numbers.count];
            }
            [self creatBottomViewWithViewNumber:(int)numbers.count andNumberCount:(int)numbers.count];
        }
            break;
        default:
            break;
    }
}

-(void)creatViewWithNumber:(TLGroupCouponCode *)code andID:(int)index andNumberCount:(int)numbers
{
    UIButton *button=[[UIButton alloc]init];
    button.tag = index;
    [button addTarget:self action:@selector(couponDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *coupon=[[UILabel alloc]init];
    coupon.text=@"券号";
    coupon.textColor = [UIColor getColor:@"999999"];
    coupon.font = [UIFont systemFontOfSize:14];
    CGSize timeSize = [ coupon.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    coupon.frame = CGRectMake(20, 10, timeSize.width, timeSize.height);
    [button addSubview:coupon];
    
    UILabel *couponCode=[[UILabel alloc]init];
    
    NSString *code1 = [code.coupon_code substringToIndex:4];
    NSString *code2 = [code.coupon_code substringWithRange:NSMakeRange(4, 4)];
    NSString *code3 = [code.coupon_code substringFromIndex:8];

    couponCode.text=[NSString stringWithFormat:@"%@ %@ %@",code1,code2,code3];
    couponCode.font = [UIFont systemFontOfSize:14];
    couponCode.textColor = [UIColor getColor:@"ff6937"];
    CGSize couponCodeSize = [couponCode.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    couponCode.bounds = CGRectMake(0, 0, couponCodeSize.width, couponCodeSize.height);
    couponCode.center = CGPointMake(CGRectGetMaxX(coupon.frame)+20+couponCodeSize.width/2, coupon.center.y);
    [button addSubview:couponCode];
    
    if ((numbers==2&&index==0) || (numbers > 2)) {
        UIView *separation = [[UIView alloc]init];
        separation.backgroundColor = [UIColor getColor:@"d6d6d6"];
        separation.frame = CGRectMake(coupon.frame.origin.x, CGRectGetMaxY(coupon.frame)+9, self.bounds.size.width-110, 1);
        [button addSubview:separation];
    }
    
    if (index == 0) {
        
        UIButton *codeButton = [[UIButton alloc]init];
        [codeButton setImage:[UIImage imageNamed:TL_QR_COUPON_DETAIL] forState:UIControlStateNormal];
        codeButton.frame = CGRectMake(self.bounds.size.width-50, 60, 20, 20);
        [codeButton addTarget:self action:@selector(code) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:codeButton];
    }
    
    button.frame=CGRectMake(10, index*(timeSize.height+20)+50, self.bounds.size.width-80, timeSize.height+20);
    [self.contentView addSubview:button];
    
    UIImageView *separationH = [[UIImageView alloc]init];
    separationH.frame = CGRectMake(self.bounds.size.width-70, index*(timeSize.height+20)+50, 1, timeSize.height+20);
    separationH.image = [UIImage imageNamed:TLLINE_SPACING_RIGHT];
    [self.contentView addSubview:separationH];
    _height = CGRectGetMaxY(button.frame);
}

-(void)code
{
    self.showCellCodeBlock();
}




-(void)couponDetail:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(groupCouponsListViewCell:withCoupon:withTLGroupCoupons:)]) {
        [self.delegate groupCouponsListViewCell:self withCoupon:_groupCoupons.coupon_code_list[button.tag] withTLGroupCoupons:_groupCoupons];
    }
}

-(void)creatBottomViewWithViewNumber:(int)i andNumberCount:(int)j{
    UIView * bottomView=[[UIView alloc]init];

    [self.contentView addSubview:bottomView];
    UIButton *button=[[UIButton alloc]init];
    UIImageView *icon = [[UIImageView alloc]init];
    [bottomView addSubview:icon];
    button.titleLabel.font = [UIFont systemFontOfSize:14];

    [button setTitleColor:[UIColor getColor:@"999999"] forState:UIControlStateNormal];
    [bottomView addSubview:button];
    if (i>2) {
        [button setTitle:@"收起" forState:UIControlStateNormal];
        icon.image = [UIImage imageNamed:TL_ICON_SHOUQI];
        
   
    }else{
        [button setTitle:[NSString stringWithFormat:@"更多%d张券",j-2] forState:UIControlStateNormal];
        icon.image = [UIImage imageNamed:TL_ICON_MORE_COUPON];
        
    }
    
    CGSize buttonSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    button.frame = CGRectMake((self.bounds.size.width-buttonSize.width-22)/2, 0, buttonSize.width+10, 40);
    icon.bounds = CGRectMake(0, 0, 12, 6);
    icon.center = CGPointMake(button.center.x+buttonSize.width/2+11, button.center.y);
    [button addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    bottomView.frame=CGRectMake(0, _height, self.bounds.size.width, 40);
    
    _height = CGRectGetMaxY(bottomView.frame);
    
}


-(void)tap{
    self.showCellBlock();
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _backgroundImageView.frame = CGRectMake(10, 50, self.bounds.size.width-20, _height-50);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
