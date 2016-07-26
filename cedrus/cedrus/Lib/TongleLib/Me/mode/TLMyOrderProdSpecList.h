//
//  TLMyOrderProdSpecList.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLMyOrderProdSpecList <NSObject>


@end

@interface TLMyOrderProdSpecList : JSONModel

//规格编号
@property (nonatomic,copy) NSString *prod_spec_id;
//规格名称
@property (nonatomic,copy) NSString *prod_spec_name;
//规格明细编号
@property (nonatomic,copy) NSString *spec_detail_id;
//规格明细名称
@property (nonatomic,copy) NSString *spec_detail_name;

@end
