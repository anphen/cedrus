//
//  TLMoshopAd.h
//  tongle
//
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLMoshopAd <NSObject>


@end

@interface TLMoshopAd : JSONModel

@property (nonatomic,copy) NSString *ad_no;
@property (nonatomic,copy) NSString *ad_pic_url;
@property (nonatomic,copy) NSString *object_id;
@property (nonatomic,copy) NSString *promotion_mode;

@end
