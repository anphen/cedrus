//
//  TLPostShare.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/23.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLPostShare : JSONModel

@property (nonatomic,copy) NSString *my_repost_id;
@property (nonatomic,copy) NSString *post_link_url;
@property (nonatomic,copy) NSString *post_image_url;
@property (nonatomic,copy) NSString *magazine_title;
//@property (nonatomic,copy) NSString *magazine_describle;
@property (nonatomic,copy) NSString *wx_profile;


@end
