//
//  TLPickerView.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPickerView.h"
#import "TLBasicData.h"
#import "TLBaseDateType.h"
#import "TLDataList.h"
#import "TLSubListData.h"
#import "TLCommon.h"

@interface TLPickerView ()

@property(nonatomic,strong) NSMutableArray *provinces;
@property (nonatomic,strong) NSMutableArray *cities;
@property (nonatomic,strong) NSMutableArray *areas;

@property(nonatomic,strong) NSMutableArray *provinces_id;
@property (nonatomic,strong) NSMutableArray *cities_id;
@property (nonatomic,strong) NSMutableArray *areas_id;

@property (nonatomic,strong) TLBasicData *baseData;
@property (nonatomic,strong) TLBaseDateType *baseDataType;
@property (nonatomic,strong) TLDataList *dataList;
@property (nonatomic,strong) TLSubListData *subListData;

@end

@implementation TLPickerView


- (id)initWithdelegate:(id <TLPickerViewDelegate>)delegate
{
   self = [[[NSBundle mainBundle] loadNibNamed:@"TLPickerView" owner:self options:nil]lastObject];
    if (self) {
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.delegate = delegate;
        [self loadBaseDate];
    }
    return self;
}

-(NSMutableArray *)provinces
{
    if (_provinces == nil) {
        _provinces = [NSMutableArray array];
    }
    return _provinces;
}

-(NSMutableArray *)provinces_id
{
    if (_provinces_id == nil) {
        _provinces_id = [NSMutableArray array];
    }
    return _provinces_id;
}

-(NSMutableArray *)cities
{
    if (_cities == nil) {
        _cities = [NSMutableArray array];
    }
    return _cities;
}

-(NSMutableArray *)cities_id
{
    if (_cities_id == nil) {
        _cities_id = [NSMutableArray array];
    }
    return _cities_id;
}

-(NSMutableArray *)areas
{
    if (_areas == nil) {
        _areas = [NSMutableArray array];
    }
    return _areas;
}

-(NSMutableArray *)areas_id
{
    if (_areas_id == nil) {
        _areas_id = [NSMutableArray array];
    }
    return _areas_id;
}

-(void)loadBaseDate
{
    TLBasicData *baseData = [[TLBasicData alloc]initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:TLBaseDataFilePath] error:nil];
    self.baseData = baseData;
    [self loadProvincesDataWithRow:0];
    if (self.provinces.count) {
        self.currentProvinces = self.provinces[0];
        self.currentProvince_id = self.provinces_id[0];
    }
    [self loadCitiesDataWithRow:0];
    if (self.cities.count) {
        self.currentCities = self.cities[0];
        self.currentCity_id = self.cities_id[0];
    }else
    {
        self.currentCities = @"";
        self.currentCity_id = @"";
    }
    [self loadAreasDataWithRow:0];
    if (self.areas.count>0) {
        self.currentAreas = self.areas[0];
        self.currentArea_id = self.areas_id[0];
    }else
    {
        self.currentAreas = @"";
        self.currentArea_id = @"";
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.provinces.count;
            break;
        case 1:
            return self.cities.count;
            break;
        case 2:
            return self.areas.count;
            break;
        default:
            return 0;
            break;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.provinces[row];
            break;
        case 1:
            if (self.cities.count) {
                return self.cities[row];
                break;
            }
        case 2:
            if (self.areas.count > 0) {
                return self.areas[row];
                break;
            }
        default:
            return @"";
            break;
    }

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [self loadCitiesDataWithRow:(int)row];
            [self reloadPickViewRow:0 Component:1 animated:YES];
            
            [self loadAreasDataWithRow:0];
            [self reloadPickViewRow:0 Component:2 animated:YES];
            
            if (self.provinces.count) {
                self.currentProvinces = self.provinces[row];
                self.currentProvince_id = self.provinces_id[row];
            }
            if (self.cities.count) {
                self.currentCities = self.cities[0];
                self.currentCity_id = self.cities_id[0];
            }else
            {
                self.currentCities = @"";
                self.currentCity_id = @"";
            }
            if (self.areas.count>0) {
                self.currentAreas = self.areas[0];
                self.currentArea_id = self.areas_id[0];
            }else
            {
                self.currentAreas = @"";
                self.currentArea_id = @"";
            }
            
            break;
           case 1:
            [self loadAreasDataWithRow:(int)row];
            [self reloadPickViewRow:0 Component:2 animated:YES];
            
            self.currentCities = self.cities[row];
            self.currentCity_id = self.cities_id[row];
            if (self.areas.count>0) {
                self.currentAreas = self.areas[0];
                self.currentArea_id = self.areas_id[0];
            }else
            {
                self.currentAreas = @"";
                self.currentArea_id = @"";
            }
            break;
            case 2:
            if (self.areas.count>0) {
                self.currentAreas = self.areas[row];
                self.currentArea_id = self.areas_id[row];
            }else
            {
                self.currentAreas = @"";
                self.currentArea_id = @"";
            }
            break;
        default:
            break;
    }
    
    if ([self.delegate respondsToSelector:@selector(pickCurrentAddress:)]) {
        [self.delegate pickCurrentAddress:self];
    }
}

//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//
//    UILabel *myview = nil;
//    
//    myview.textAlignment = NSTextAlignmentCenter;
//    switch (component) {
//        case 0:
//            myview.text = self.provinces[row];
//            break;
//        case 1:
//            if (self.cities.count) {
//                 myview.text = self.cities[row];
//                break;
//            }
//        case 2:
//            if (self.areas.count > 0) {
//                myview.text = self.areas[row];
//                break;
//            }
//        default:
//            myview.text = @"";
//            break;
//    }
//    myview.font = [UIFont systemFontOfSize:13];
//    myview.backgroundColor = [UIColor clearColor];
//    return myview;
//}

-(void)loadProvincesDataWithRow:(int)row
{
    [self.provinces removeAllObjects];
    [self.provinces_id removeAllObjects];
    if (self.baseData.base_data_list.count) {
        TLBaseDateType *baseDateType = self.baseData.base_data_list[row];
        self.baseDataType = baseDateType;
        for (TLDataList *dataListPro in baseDateType.data_list) {
            [self.provinces addObject:dataListPro.name];
            [self.provinces_id addObject:dataListPro.code];
        }
    }
}

-(void)loadCitiesDataWithRow:(int)row
{
    [self.cities removeAllObjects];
    [self.cities_id removeAllObjects];
    if (self.baseDataType.data_list.count) {
        TLDataList *dataList = self.baseDataType.data_list[row];
        self.dataList = dataList;
        for (TLDataList *dataListCity in dataList.sub_list)
        {
            [self.cities addObject:dataListCity.name];
            [self.cities_id addObject:dataListCity.code];
        }
    }
    
}

-(void)loadAreasDataWithRow:(int)row
{
    [self.areas removeAllObjects];
    [self.areas_id removeAllObjects];
    if (self.dataList.sub_list.count) {
        TLDataList *dataListlast = self.dataList.sub_list[row];
        for (TLDataList *dataListAreas in dataListlast.sub_list)
        {
            [self.areas addObject:dataListAreas.name];
            [self.areas_id addObject:dataListAreas.code];
        }
    }
    
}

-(void)reloadPickViewRow:(int)row Component:(int)component animated:(BOOL)isbool
{
    [self.pickerView selectRow:row inComponent:component animated:isbool];
    [self.pickerView reloadComponent:component];
}


-(void)showPickView:(UIView *)view
{
    self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height-self.frame.size.height, view.frame.size.width, self.frame.size.height);
    }];
}

-(void)hidePickView:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
         self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
