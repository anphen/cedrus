//
//  TLGroupPurchaseShopViewList.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/8.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupPurchaseShopViewList.h"
#import "UIImageView+Image.h"
#import "TLImageName.h"

@interface TLGroupPurchaseShopViewList ()

@property (weak, nonatomic) IBOutlet UILabel *shopName;
//@property (weak, nonatomic) IBOutlet UILabel *positive;
//@property (weak, nonatomic) IBOutlet UILabel *Price_No;
//@property (weak, nonatomic) IBOutlet UILabel *goods;

@end




@implementation TLGroupPurchaseShopViewList

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)table
{
    /**
     *  设置缓存池中cell的标识
     */
    static NSString *ID = @"TLGroupPurchaseShopViewList";
    
    TLGroupPurchaseShopViewList *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        /**
         第一次要自己创建
         */
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
    }
    return cell;
}

-(void)setGroupStore:(TLGroupStoreList *)groupStore
{
    _groupStore = groupStore;
    _shopName.text = groupStore.name;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
