//
//  TLSpecDetailList.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLSpecDetailList <NSObject>


@end


@interface TLSpecDetailList : JSONModel

//规格明细ID
@property (nonatomic,copy) NSString *spec_detail_id;
//规格明细名称
@property (nonatomic,copy) NSString *spec_detail_name;


@end
