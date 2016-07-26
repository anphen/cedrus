//
//  TLGroupProdSpecList.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/29.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLSpecDetailList.h"


@protocol TLGroupProdSpecList <NSObject>


@end

@interface TLGroupProdSpecList : JSONModel


//规格ID
@property (nonatomic,copy) NSString *prod_spec_id;
//规格名称
@property (nonatomic,copy) NSString *prod_spec_name;

//规格明细列表
@property (nonatomic,strong) NSArray<TLSpecDetailList,ConvertOnDemand> *spec_detail_list;


@end
