//
//  TLGroupPurchaseShopViewList.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/8.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLGroupStoreList.h"


@interface TLGroupPurchaseShopViewList : UITableViewCell

@property (nonatomic,strong) TLGroupStoreList *groupStore;


+(instancetype)cellWithTableView:(UITableView *)table;

@end
