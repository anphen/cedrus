//
//  TLProdImageList.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdImageDetails.h"

@interface TLProdImageList : JSONModel

@property (nonatomic,strong) NSArray<TLProdImageDetails,ConvertOnDemand> *prod_pic_text_list;

@end
