//
//  TL_Community_DatePicker.h
//  tlcommunity
//
//  Created by jixiaofei-mac on 15-9-6.
//  Copyright (c) 2015年 ilingtong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLDatePicker;

@protocol TLDatePicker_Delegate <NSObject>

@optional

-(void)DatePicker:(TLDatePicker *)TLDatePicker withBarButtonItem:(UIBarButtonItem *)barButtonItem;

@end


@interface TLDatePicker : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *datapicker;



@property (nonatomic,assign) id<TLDatePicker_Delegate>delegate;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

- (IBAction)sureButton:(UIBarButtonItem *)sender;


+(id)init;

@end
