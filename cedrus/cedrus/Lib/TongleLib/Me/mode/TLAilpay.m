//
//  TLAilpay.m
//  tongle
//
//  Created by jixiaofei-mac on 15-8-7.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLAilpay.h"

@implementation TLAilpay


- (NSString *)description {
    NSMutableString * discription = [NSMutableString string];
    if (self.partner.length) {
        [discription appendFormat:@"partner=\"%@\"", self.partner];
    }
    
    if (self.seller_id.length) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.seller_id];
    }
    if (self.out_trade_no.length) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.out_trade_no];
    }
    if (self.subject.length) {
        [discription appendFormat:@"&subject=\"%@\"", self.subject];
    }
    
    if (self.body.length) {
        [discription appendFormat:@"&body=\"%@\"", self.body];
    }
    if (self.total_fee.length) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.total_fee];
    }
    if (self.notify_url.length) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notify_url];
    }
    
    if (self.service.length) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.payment_type.length) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.payment_type];//1
    }
    
    if (self.input_charset.length) {
        [discription appendFormat:@"&_input_charset=\"%@\"",self.input_charset];//utf-8
    }
    if (self.it_b_pay.length) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.it_b_pay];//30m
    }
    if (self.app_id.length) {
        [discription appendFormat:@"&app_id=\"%@\"",self.app_id];
    }
    return discription;
}


@end
