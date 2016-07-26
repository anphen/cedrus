//
//  TLMy_Income_List.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLMy_Income_List : NSObject
/**
 *  收益类型
 */
@property (nonatomic,copy) NSString *income_type;
/**
 *  区间类型
 */
@property (nonatomic,copy) NSString *period_type;
/**
 *  曲线标题名称
 */
@property (nonatomic,copy) NSString *chart_title;
/**
 *  曲线颜色代码
 */
@property (nonatomic,copy) NSString *chart_color;
/**
 *  曲线X轴字段名
 */
@property (nonatomic,copy) NSString *chart_x_field_name;
/**
 *  曲线Y轴字段名
 */
@property (nonatomic,copy) NSString *chart_y_field_name;
/**
 *  曲线Y轴最小值
 */
@property (nonatomic,copy) NSString *chart_y_min_value;
/**
 *  曲线Y轴最大值
 */
@property (nonatomic,copy) NSString *chart_y_max_value;
/**
 *  收益数据列表
 */
@property (nonatomic,strong) NSArray *income_list;


@end
