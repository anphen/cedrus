//
//  TLBalanceCurveViewController.m
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLBalanceCurveViewController.h"
#import "LineChartView.h"
#import "NSDate+Additions.h"
#import "TLMy_Income.h"
#import "TLMy_Income_List.h"
#import "TLMyIncome_List.h"
#import "TLCommon.h"
#import "UIColor+TL.h"

@interface TLBalanceCurveViewController ()

@property (nonatomic,strong) TLMy_Income *my_income;
@property (nonatomic,weak) LineChartView *chartView;
@property (nonatomic,weak) UISegmentedControl *segmentedControl;

@end

@implementation TLBalanceCurveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSegment];
    [self controlPressed:self.segmentedControl];
}

-(void)setUpSegment
{
    UISegmentedControl *segmented = [[UISegmentedControl alloc]init];
    [segmented insertSegmentWithTitle:@"Day" atIndex:0 animated:NO];
    [segmented setSelectedSegmentIndex:0];
    [segmented addTarget:self action:@selector(controlPressed:) forControlEvents:UIControlEventValueChanged];
    [segmented insertSegmentWithTitle:@"Week" atIndex:1 animated:NO];
    [segmented insertSegmentWithTitle:@"Month" atIndex:2 animated:NO];
    [segmented insertSegmentWithTitle:@"Year" atIndex:3 animated:NO];
    segmented.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 30);
    [self.view addSubview:segmented];
    self.segmentedControl = segmented;
}


-(void)controlPressed:(UISegmentedControl *)segmented
{
    int index = (int)[segmented selectedSegmentIndex];
    if (index == 0) {
        [self createChatViewWithFile:TLMyDayFilePath];
    }else if (index == 1)
    {
         [self createChatViewWithFile:TLMyWeekFilePath];
    }else if (index == 2)
    {
        [self createChatViewWithFile:TLMyMonFilePath];
    }else
    {
         [self createChatViewWithFile:TLMyYearFilePath];
    }
}

-(void)createChatViewWithFile:(id)file
{
    [self.chartView removeFromSuperview];
    self.my_income = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
//#warning 需要修改有错
    if( self.my_income.my_income_list.count) {
        
        TLMy_Income_List *my_Income_List = self.my_income.my_income_list[2];
        LineChartData *d1x = [LineChartData new];
        
        [self createChat:d1x with:my_Income_List withColor:[UIColor getColor:@"d84d4d"]];
        
        LineChartView *chartViewsub = [[LineChartView alloc] initWithFrame:CGRectMake(20, 50, self.view.frame.size.width-40, 300)];
        chartViewsub.yMin = 0;
        chartViewsub.yMax = 100;
        chartViewsub.data = @[d1x];
        self.chartView = chartViewsub;
        [self.view addSubview:chartViewsub];
    }
    
}


-(void)createChat:(LineChartData *)chartData with:(TLMy_Income_List *)my_Income_List withColor:(UIColor *)color
{
    LineChartData *d1 = chartData;
    
    d1.title = my_Income_List.chart_title;
    d1.color = color;
    d1.itemCount = my_Income_List.income_list.count;
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arr3 = [NSMutableArray array];
    
    for (int i=0; i<my_Income_List.income_list.count; i++) {
        TLMyIncome_List *myIncome = my_Income_List.income_list[i];
        if (i==0) {
            d1.xMin = [[self date:myIncome.date] timeIntervalSinceReferenceDate];
        }
        if (i==my_Income_List.income_list.count-1) {
            d1.xMax = [[self date:myIncome.date] timeIntervalSinceReferenceDate];
        }
        [arr addObject:@([[self date:myIncome.date] timeIntervalSinceReferenceDate])];
        [arr3 addObject:myIncome.date];
    }
    [arr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableArray *arr2 = [NSMutableArray array];
    
    
    for (TLMyIncome_List *myIncome in my_Income_List.income_list) {
        [arr2 addObject:myIncome.amount];
    }
    d1.getData = ^(NSUInteger item) {
        float x = [arr[item] floatValue];
        float y = [arr2[item] floatValue];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *label1 = arr3[item];
        NSString *label2 = [NSString stringWithFormat:@"%.2f", y];
        return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2];
    };
    
}


-(NSDate *)date:(NSString *)date
{
    
    NSString *year  = [date substringToIndex:4];
    NSString *mon = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [date substringFromIndex:8];
    NSString *result = [NSString stringWithFormat:@"%@%@%@",year,mon,day];
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    
    
    NSDate *inputDate = [inputFormatter dateFromString:result];
    
    
    return inputDate;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based TLlication, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
