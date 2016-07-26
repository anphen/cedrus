//
//  TLPordImageDetails.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLProdImageDetails <NSObject>


@end

@interface TLProdImageDetails : JSONModel

@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,copy) NSString *pic_memo;

@end
