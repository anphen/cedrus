//
//  TLPostDetail.h
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLUserPostInfo.h"

@interface TLPostDetail : JSONModel

@property (nonatomic,strong) TLUserPostInfo *user_post_info;
@end
