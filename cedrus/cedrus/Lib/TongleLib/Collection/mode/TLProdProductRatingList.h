//
//  TLProdProductRatingList.h
//  tongle
//
//  Created by liu ruibin on 15-5-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLProdProductRatingList <NSObject>

@end

@interface TLProdProductRatingList : JSONModel

@property (nonatomic,copy) NSString *rating_doc_no;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *rating_date;
@property (nonatomic,copy) NSString *user_nick_name;
@property (nonatomic,copy) NSString *head_photo_url;
@property (nonatomic,copy) NSString *memo;


@end
