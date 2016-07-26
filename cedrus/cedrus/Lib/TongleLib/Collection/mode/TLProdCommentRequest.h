//
//  TLProdCommentRequest.h
//  tongle
//
//  Created by liu ruibin on 15-5-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLCommon.h"

@interface TLProdCommentRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *rating_doc_no;
@property (nonatomic,copy) NSString *forward;
@property (nonatomic,copy) NSString *fetch_count;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
