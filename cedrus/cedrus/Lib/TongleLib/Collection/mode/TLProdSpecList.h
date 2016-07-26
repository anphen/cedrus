//
//  TLProdSpecList.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLSpecDetailList.h"

@protocol TLProdSpecList <NSObject>


@end

@interface TLProdSpecList : JSONModel

//规格ID
@property (nonatomic,copy) NSString *prod_spec_id;
//规格名称
@property (nonatomic,copy) NSString *prod_spec_name;
//是否可变更标志
@property (nonatomic,copy) NSString *can_be_modify_flag;
//规格明细列表
@property (nonatomic,strong) NSArray<TLSpecDetailList,ConvertOnDemand> *spec_detail_list;


@end
