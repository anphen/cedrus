//
//  TLPostInfo.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLPostInfo <NSObject>


@end


@interface TLPostInfo : JSONModel

@property (nonatomic,copy) NSString *post_id;
@property (nonatomic,copy) NSString *my_post_flag;
@property (nonatomic,copy) NSString *post_comment;
@property (nonatomic,copy) NSString *prod_link_url;


@end
