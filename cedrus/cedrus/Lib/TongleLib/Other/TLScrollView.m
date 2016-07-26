//
//  TLScrollView.m
//  TL11
//
//  Created by liu on 15-4-20.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLScrollView.h"
#import "TLCollectViewController.h"

@implementation TLScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(void)ScrollViewWithControllerArray:(NSArray *)array Controller:(UIViewController *)controller
{
    CGRect frame = [UIScreen mainScreen].bounds;

    
    TLScrollView *scrollView = [[TLScrollView alloc] initWithFrame:CGRectMake(0, 108, frame.size.width, frame.size.height-108)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    

    for (int i = 0; i<array.count; i++) {
        UIViewController *controllersuber = array[i];
        if ([controller isKindOfClass:[TLCollectViewController class]]) {
            controllersuber.view.frame = CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height-108-49);
        }else
        {
            controllersuber.view.frame = CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height-108);
        }
        controllersuber.view.frame = CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height-108-49);
        [controller addChildViewController:controllersuber];
        [scrollView addSubview:controller.view];
    }
    [controller.view addSubview:scrollView];
    
    
}



@end
