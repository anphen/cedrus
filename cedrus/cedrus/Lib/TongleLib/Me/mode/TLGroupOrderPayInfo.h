//
//  TLGroupOrderPayInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupOrderPayInfo <NSObject>


@end



@interface TLGroupOrderPayInfo : JSONModel


@property (nonatomic,copy) NSString *pay_type;
@property (nonatomic,copy) NSString *pay_status;


@end
