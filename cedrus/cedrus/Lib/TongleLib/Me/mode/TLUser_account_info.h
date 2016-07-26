//
//  TLUser_account_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15/11/19.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//



#import "JSONModel.h"
#import <Foundation/Foundation.h>
#import "TLMyAccount_list.h"


@protocol TLUser_account_info


@end


@interface TLUser_account_info : JSONModel

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,strong) NSArray<TLMyAccount_list,ConvertOnDemand> *account_list;
@property (nonatomic,copy) NSString *withdraw_url;
@property (nonatomic,copy) NSString *withdraw_title;



@end
