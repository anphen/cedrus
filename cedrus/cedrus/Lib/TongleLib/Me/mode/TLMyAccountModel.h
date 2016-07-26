//
//  TLMyAccountModel.h
//  tongle
//
//  Created by jixiaofei-mac on 15/11/19.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import <Foundation/Foundation.h>
#import "TLUser_account_info.h"


@interface TLMyAccountModel : JSONModel

@property (nonatomic,strong)  TLUser_account_info *user_account_info;


@end
