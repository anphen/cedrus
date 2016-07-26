//
//  TLProdDetailsMeg.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdDetails.h"
#import "TLPostInfo.h"

@interface TLProdDetailsMeg : JSONModel

@property (nonatomic ,strong) TLProdDetails *prod_info;
@property (nonatomic ,strong) TLPostInfo *post_info;

@end
