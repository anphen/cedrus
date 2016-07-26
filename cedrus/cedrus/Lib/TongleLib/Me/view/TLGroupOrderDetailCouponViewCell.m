//
//  TLGroupOrderDetailCouponViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupOrderDetailCouponViewCell.h"
#import "TLGroupDetailCoupon.h"
#import "TLImageName.h"
#import "UIImage+TL.h"
#import "UIColor+TL.h"

@interface TLGroupOrderDetailCouponViewCell ()

@property (nonatomic,weak) UIImageView *backgroundImageView;

@end


@implementation TLGroupOrderDetailCouponViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"TLGroupOrderDetailCouponViewCell";
    [tableview registerClass:self forCellReuseIdentifier:ID];
    TLGroupOrderDetailCouponViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor getColor:@"f4f4f4"];
    return cell;
}


-(void)setGroupDetailCouponDict:(NSDictionary *)groupDetailCouponDict
{
    _groupDetailCouponDict = groupDetailCouponDict;
    [self setCellWithGroupCoupons:groupDetailCouponDict];
}

-(void)setCellWithGroupCoupons:(NSDictionary *)groupDetailCouponDictionary
{
    
    NSArray *groupDetailCouponArray = [groupDetailCouponDictionary objectForKey:@"couponArray"];
    NSString *couponType = [groupDetailCouponDictionary objectForKey:@"couponType"];
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.image = [UIImage resizedImage:TLCOUPON_BACKGROUND leftScale:0.8 topScale:0.8];
    [self.contentView addSubview:backgroundImageView];
    _backgroundImageView = backgroundImageView;
    
    CGFloat WIDTH = self.superview.bounds.size.width;
    
    UIImageView * headView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, 30)];
    
    if (![couponType isEqualToString:@"可使用"]) {
        headView.image = [UIImage imageNamed:USED_REFUNDED_COUPON_TOP];
    }else
    {
        headView.image = [UIImage imageNamed:COUPON_TOP];
    }
    
    UILabel *storeName=[[UILabel alloc]init];
    storeName.font = [UIFont systemFontOfSize:14];
    storeName.textColor = [UIColor whiteColor];
    if ([couponType isEqualToString:@"可使用"]) {
        storeName.text= [NSString stringWithFormat:@"可使用%lu张",(unsigned long)groupDetailCouponArray.count];
    }else if ([couponType isEqualToString:@"已退款"])
    {
        float price = 0;
        for (TLGroupDetailCoupon *groupDetailCoupon in groupDetailCouponArray) {
            price = price + [groupDetailCoupon.amount floatValue];
        }
        storeName.text= [NSString stringWithFormat:@"已退款￥%.2f",price];
    }else if ([couponType isEqualToString:@"已消费"])
    {
        storeName.text= @"已消费";
    }else if ([couponType isEqualToString:@"已过期"])
    {
       storeName.text= @"已过期";
    }else
    {
       storeName.text= @"退款中";
    }

    CGSize storeNameSize = [ storeName.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    storeName.frame = CGRectMake(20, 0, storeNameSize.width, 30);
    [headView addSubview:storeName];
    
    
    UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2, 0, WIDTH/2, 30)];//
    time.textColor = [UIColor whiteColor];
    time.font = [UIFont systemFontOfSize:10];
    if (groupDetailCouponArray.count == 1) {
        TLGroupDetailCoupon *groupDetailCoupon = groupDetailCouponArray[0];
         time.text= [NSString stringWithFormat:@"%@",groupDetailCoupon.operator_date];
    }else
    {
        TLGroupDetailCoupon *groupDetailCouponfirst = groupDetailCouponArray[0];
        TLGroupDetailCoupon *groupDetailCouponlast = groupDetailCouponArray.lastObject;
        time.text= [NSString stringWithFormat:@"%@-%@",groupDetailCouponfirst.operator_date,groupDetailCouponlast.operator_date];
    }

    CGSize timeSize = [ time.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10]}];
    time.frame = CGRectMake(headView.bounds.size.width-10-timeSize.width, 0, timeSize.width, 30);
    [headView addSubview:time];
    [self.contentView addSubview:headView];
    
    for (int i=0; i<groupDetailCouponArray.count; i++) {
        TLGroupDetailCoupon *groupDetailCoupon = groupDetailCouponArray[i];
        [self creatViewWithGroupDetailCoupon:groupDetailCoupon andCouponType:couponType andID:i andNumberCount:(int)groupDetailCouponArray.count];
    }
}

-(void)creatViewWithGroupDetailCoupon:(TLGroupDetailCoupon *)groupDetailCoupon andCouponType:(NSString *)couponType andID:(int)index andNumberCount:(int)numbers
{
    
    UIButton *button=[[UIButton alloc]init];
    button.tag = index;
   // [button addTarget:self action:@selector(couponDetail:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *coupon=[[UILabel alloc]init];
    coupon.text=@"券号";
    coupon.textColor = [UIColor getColor:@"999999"];
    coupon.font = [UIFont systemFontOfSize:14];
    CGSize timeSize = [ coupon.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    coupon.frame = CGRectMake(20, 10, timeSize.width, timeSize.height);
    [button addSubview:coupon];
    
    UILabel *couponCode=[[UILabel alloc]init];
    couponCode.font = [UIFont systemFontOfSize:14];
    
    NSString *code1 = [groupDetailCoupon.coupon_id substringToIndex:4];
    NSString *code2 = [groupDetailCoupon.coupon_id substringWithRange:NSMakeRange(4, 4)];
    NSString *code3 = [groupDetailCoupon.coupon_id substringFromIndex:8];
    

    NSString *couponCodeString=[NSString stringWithFormat:@"%@ %@ %@",code1,code2,code3];
    
    
    if ([couponType isEqualToString:@"已退款"]) {
        couponCode.textColor = [UIColor getColor:@"999999"];
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        //下划线
        //        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:couponCodeString attributes:attribtDic];
        couponCode.attributedText = attribtStr;
    }else if([couponType isEqualToString:@"可使用"])
    {
        couponCode.text=couponCodeString;
        couponCode.textColor = [UIColor getColor:@"ff6937"];
    }else
    {
        couponCode.text=couponCodeString;
        couponCode.textColor = [UIColor getColor:@"999999"];
    }
    CGSize couponCodeSize = [couponCodeString sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]}];
    couponCode.bounds = CGRectMake(0, 0, couponCodeSize.width, couponCodeSize.height);
    couponCode.center = CGPointMake(CGRectGetMaxX(coupon.frame)+20+couponCodeSize.width/2, coupon.center.y);
    [button addSubview:couponCode];
    [self.contentView addSubview:button];
    
    if ((numbers > 1)&&(index != (numbers-1)))
    {
        UIView *separation = [[UIView alloc]init];
        separation.backgroundColor = [UIColor getColor:@"d6d6d6"];
        [button addSubview:separation];
        separation.frame = CGRectMake(coupon.frame.origin.x, CGRectGetMaxY(coupon.frame)+9, self.bounds.size.width-110, 1);
    }
    
    
    if (index == 0 && [couponType isEqualToString:@"可使用"]) {
        
        UIButton *codeButton = [[UIButton alloc]init];
        [codeButton setImage:[UIImage imageNamed:TL_QR_COUPON_DETAIL] forState:UIControlStateNormal];
        codeButton.frame = CGRectMake(self.bounds.size.width-50, 40, 20, 20);
        [codeButton addTarget:self action:@selector(code) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:codeButton];
    }
    
    
    button.frame=CGRectMake(10, index*(timeSize.height+20)+30, self.bounds.size.width-80, timeSize.height+20);
    [self.contentView addSubview:button];
    
    
    UIImageView *separationH = [[UIImageView alloc]init];
    separationH.frame = CGRectMake(self.bounds.size.width-70, index*(timeSize.height+20)+30, 1, timeSize.height+20);
    separationH.image = [UIImage imageNamed:TLLINE_SPACING_RIGHT];
    [self.contentView addSubview:separationH];
    _height = CGRectGetMaxY(button.frame);
    
}

-(void)code
{
    self.codebutton();
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _backgroundImageView.frame = CGRectMake(10, 30, self.bounds.size.width-20, _height-30);
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
