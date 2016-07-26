//
//  TLGroupUiBtnControlList.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupUiBtnControlList <NSObject>


@end



@interface TLGroupUiBtnControlList : JSONModel

@property (nonatomic,copy) NSString *btn_func_key;
@property (nonatomic,copy) NSString *btn_status;
@property (nonatomic,copy) NSString *btn_name;


@end
