//
//  TLAddressesListViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLAddressesListViewCell.h"
#import "TLAddress.h"

@interface TLAddressesListViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
@property (weak, nonatomic) IBOutlet UILabel *tel;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectBtn:(UIButton *)sender;

@end



@implementation TLAddressesListViewCell

-(void)setRightselected:(BOOL)rightselected
{
    _rightselected = rightselected;
    self.selectBtn.hidden = !rightselected;
}

-(void)setAddress:(TLAddress *)address
{
    _address = address;
    
    self.userName.text = address.consignee;
    self.detailAddress.text=[NSString stringWithFormat:@"%@%@%@%@",address.province_name,address.city_name,address.area_name,address.address];
    self.tel.text = address.tel;
    self.selectBtn.hidden = YES;
    self.rightselected = ![address.default_flag intValue];
}

+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"addressesList";
    TLAddressesListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLAddressesListViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}



- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtn:(UIButton *)sender {
}
@end
