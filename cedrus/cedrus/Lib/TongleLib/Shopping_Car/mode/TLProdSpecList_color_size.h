//
//  TLProdSpecList.h
//  tongle
//
//  Created by liu on 15-5-6.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol  TLProdSpecList_color_size

@end

@interface TLProdSpecList_color_size : JSONModel
//规格ID
@property (nonatomic,copy) NSString *prod_spec_id;
//规格名称
@property (nonatomic,copy) NSString *prod_spec_name;
//规格明细ID
@property (nonatomic,copy) NSString *spec_detail_id;
//规格明细名称
@property (nonatomic,copy) NSString *spec_detail_name;


@end
