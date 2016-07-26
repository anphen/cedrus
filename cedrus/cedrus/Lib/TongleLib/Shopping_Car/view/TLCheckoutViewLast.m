//
//  TLCheckoutView.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLCheckoutViewLast.h"

@implementation TLCheckoutViewLast : UITableViewCell


-(void)setTotaText:(NSString *)totaText
{
    _totaText = totaText;
    
    self.total.text = totaText;
    
}


+(instancetype)cellWithTableView:(UITableView *)table
{
    static NSString *ID = @"checkoutViewLast";
    TLCheckoutViewLast *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TLCheckoutViewLast" owner:self options:nil] lastObject];
    }
    return cell;
}



- (IBAction)submitButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(TLCheckoutViewLast:)]) {
        [self.delegate TLCheckoutViewLast:self];
    }
    
}


@end
