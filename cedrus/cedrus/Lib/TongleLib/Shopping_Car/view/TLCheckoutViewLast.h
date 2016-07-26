//
//  TLCheckoutView.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLCheckoutViewLast;

@protocol TLCheckoutViewLastDelegate <NSObject>

@optional

-(void)TLCheckoutViewLast:(TLCheckoutViewLast *)TLCheckoutViewLast;

@end


@interface TLCheckoutViewLast : UITableViewCell

@property (nonatomic,copy) NSString             *totaText;

@property (weak, nonatomic) IBOutlet UILabel    *total;

@property (weak, nonatomic) IBOutlet UIButton   *submit;

@property (nonatomic,weak)id<TLCheckoutViewLastDelegate> delegate;

- (IBAction)submitButton:(UIButton *)sender;


+(instancetype)cellWithTableView:(UITableView *)table;

@end
