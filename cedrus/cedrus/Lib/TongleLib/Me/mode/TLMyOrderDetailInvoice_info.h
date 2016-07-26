//
//  TLMyOrderDetailInvoice_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLMyOrderDetailInvoice_info 


@end

@interface TLMyOrderDetailInvoice_info : JSONModel

/**
 *  发票类别编号
 */
@property (nonatomic,copy) NSString *invoice_type_no;
/**
 *  发票类别名称
 */
@property (nonatomic,copy) NSString *invoice_type_name;
/**
 *  发票内容类别
 */
@property (nonatomic,copy) NSString *invoice_content_flag;
/**
 *  发票内容类别名称
 */
@property (nonatomic,copy) NSString *invoice_content_flag_name;
/**
 *  发票抬头
 */
@property (nonatomic,copy) NSString *inovice_title;

@end
