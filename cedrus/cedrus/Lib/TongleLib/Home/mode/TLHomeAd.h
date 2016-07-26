//
//  TLHomeAd.h
//  tongle
//
//  Created by liu ruibin on 15-5-8.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLHomepage_ads.h"

@interface TLHomeAd : JSONModel

@property (nonatomic,strong) NSArray<TLHomepage_ads,ConvertOnDemand> *top_promotion_list;


@end
