//
//  TLMyPoint.h
//  tongle
//
//  Created by jixiaofei-mac on 15/11/11.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLMyPoint : JSONModel

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *begin_qty;
@property (nonatomic,copy) NSString *latest_add_qty;
@property (nonatomic,copy) NSString *freeze_qty;
@property (nonatomic,copy) NSString *expense_qty;
@property (nonatomic,copy) NSString *available_qty;
@property (nonatomic,copy) NSString *withdraw_url;
@property (nonatomic,copy) NSString *withdraw_title;


@end
