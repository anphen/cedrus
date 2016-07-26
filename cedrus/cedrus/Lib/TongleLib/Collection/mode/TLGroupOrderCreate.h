//
//  TLGroupOrderCreate.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLGroupOrderCreate : JSONModel

@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *order_status;

@end
