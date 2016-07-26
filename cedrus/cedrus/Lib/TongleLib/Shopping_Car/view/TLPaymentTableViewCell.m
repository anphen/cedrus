//
//  TLPaymentTableViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/14.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLPaymentTableViewCell.h"
#import "TLDataList.h"
#import "TLImageName.h"


@interface TLPaymentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *payType;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end


@implementation TLPaymentTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"payment";
    
    TLPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setData:(TLDataList *)data
{
    _data = data;
    _payType.text = [NSString stringWithFormat:@"用%@",data.name];
    
    [self setPayImage:data.code];
}

-(void)setPayImage:(NSString *)code
{
    switch ([code intValue]) {
        case 0:
            _image.image = [UIImage imageNamed:TL_HUODAOFUKUAN];
            break;
        case 1:
            _image.image = [UIImage imageNamed:TL_ICON_ALIPAY];
            break;
        case 3:
            _image.image = [UIImage imageNamed:TL_ICON_WECHAT];
            break;
        case 4:
            _image.image = [UIImage imageNamed:TL_ICON_YINLIAN];
            break;
        default:
            break;
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
