//
//  TLStock_List.h
//  tongle
//
//  Created by jixiaofei-mac on 15/12/23.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLStock_List <NSObject>

@end

@interface TLStock_List : JSONModel

@property (nonatomic,copy) NSString *spec_detail_id1;
@property (nonatomic,copy) NSString *spec_detail_id2;
@property (nonatomic,copy) NSString *spec_stock_qty;
@property (nonatomic,copy) NSString *spec_price;
@property (nonatomic,copy) NSString *stock_memo;

@end
