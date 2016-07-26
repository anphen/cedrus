//
//  TLPickerView.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPickerView;


@protocol TLPickerViewDelegate <NSObject>

@optional

-(void)pickCurrentAddress:(TLPickerView *)pickView;

@end

@interface TLPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,copy) NSString *currentProvinces;
@property (nonatomic,copy) NSString *currentCities;
@property (nonatomic,copy) NSString *currentAreas;

@property (nonatomic,copy) NSString *currentProvince_id;
@property (nonatomic,copy) NSString *currentCity_id;
@property (nonatomic,copy) NSString *currentArea_id;

@property (nonatomic,weak) id<TLPickerViewDelegate> delegate;


- (id)initWithdelegate:(id <TLPickerViewDelegate>)delegate;
-(void)showPickView:(UIView *)view;
-(void)hidePickView:(UIView *)view;

@end
