//
//  TLProdShare.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/23.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLProdShare : JSONModel

@property (nonatomic,copy) NSString *prod_link_url;
@property (nonatomic,copy) NSString *prod_image_url;
@property (nonatomic,copy) NSString *magazine_title;
@property (nonatomic,copy) NSString *wx_profile;

@end
