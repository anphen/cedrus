//
//  TLVoucher.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLVoucherBaseDict.h"

@interface TLVoucher : JSONModel

@property(nonatomic,strong) NSArray<TLVoucherBaseDict,ConvertOnDemand> *voucher;

@end
