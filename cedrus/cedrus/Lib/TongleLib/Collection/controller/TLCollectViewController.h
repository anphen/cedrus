//
//  TLCollectViewController.h
//  TL11
// 收藏父控制器
//  Created by liu ruibin on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPostViewController,TLNavigationBar,TLMasterParam;


@interface TLCollectViewController : UIViewController

@property (nonatomic,strong) TLMasterParam *master;
@property (nonatomic,weak) UINavigationBar *bar;
@property (nonatomic,weak) TLNavigationBar *navigationBar;

@end
