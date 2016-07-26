//
//  TLVoucherBaseDict.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

#import "TLVoucherBase.h"

@protocol TLVoucherBaseDict <NSObject>


@end

@interface TLVoucherBaseDict : JSONModel

@property(nonatomic,strong) TLVoucherBase  *voucher_base;

@end
