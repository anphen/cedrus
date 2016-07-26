//
//  TLProdMeg.h
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdSpecList.h"
#import "TLProdDetails.h"

@class TLProdMeg;


@protocol TLProdMegDelegate <NSObject>

@optional

-(void)ProdMeg:(TLProdMeg *)prodMeg withMutableArray:(NSMutableArray *)prod_spec_list_array munber:(int)amount price:(NSString *)price;
-(void)ProdMegCreate:(TLProdMeg *)prodMeg withMutableArray:(NSMutableArray *)prod_spec_list_array;

@end

@interface TLProdMeg : UIView


@property (nonatomic,strong)    TLProdDetails   *prodDetails;
@property (nonatomic,strong)    TLStock_List    *stock_list;
@property (nonatomic,strong)    NSArray         *prodSpecListArray;
@property (nonatomic,assign,readonly) CGFloat   height;
@property (nonatomic,weak)      UILabel         *prodCount;
@property (nonatomic,weak)      UILabel         *countLabel;
@property (nonatomic,weak)      UILabel         *spec_stock_qty;
@property (nonatomic,strong)    NSMutableArray  *prod_spec_list_array;
@property (nonatomic,strong)    NSDictionary    *selectDic;
@property (nonatomic,copy)      NSString        *prod_Price;

@property (nonatomic,weak)      UIButton    *decreaseBtn;
@property (nonatomic,weak)      UIButton    *addBtn;
@property (nonatomic,weak) id<TLProdMegDelegate> delegate;

@end
