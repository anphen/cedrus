//
//  TLMyAccount_list.h
//  tongle
//
//  Created by jixiaofei-mac on 15/11/19.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import <Foundation/Foundation.h>

@protocol TLMyAccount_list


@end

@interface TLMyAccount_list : JSONModel

@property (nonatomic,copy) NSString *account_type_id;
@property (nonatomic,copy) NSString *account_type_name;
@property (nonatomic,copy) NSString *account_qty;
@property (nonatomic,copy) NSString *account_detail_title;
@property (nonatomic,copy) NSString *account_detail_url;

@end
