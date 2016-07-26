//
//  TLProdComment.h
//  tongle
//
//  Created by liu ruibin on 15-5-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdProductRatingList.h"

@interface TLProdComment : JSONModel

@property (nonatomic,copy) NSString *data_total_count;
@property (nonatomic,strong) NSArray<TLProdProductRatingList,ConvertOnDemand> *product_rating_list;
@end
