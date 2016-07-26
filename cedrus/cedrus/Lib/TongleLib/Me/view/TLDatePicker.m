//
//  TL_Community_DatePicker.m
//  tlcommunity
//
//  Created by jixiaofei-mac on 15-9-6.
//  Copyright (c) 2015年 ilingtong. All rights reserved.
//

#import "TLDatePicker.h"

@interface TLDatePicker ()


@end

@implementation TLDatePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    if ([self.delegate respondsToSelector:@selector(DatePicker:withBarButtonItem:)]) {
        [self.delegate DatePicker:self withBarButtonItem:sender];
    }
}

- (IBAction)sureButton:(UIBarButtonItem *)sender {
    if ([self.delegate respondsToSelector:@selector(DatePicker:withBarButtonItem:)]) {
        [self.delegate DatePicker:self withBarButtonItem:sender];
    }
}

+(id)init
{
    TLDatePicker *datepicker = [[[NSBundle mainBundle]loadNibNamed:@"TLDatePicker" owner:self options:nil]lastObject];
    return datepicker;
}

@end
