//
//  TLMyFiledTableViewCell.m
//  tongle
//
//  Created by ruibin liu on 15/6/20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyFiledTableViewCell.h"
#import "TLProd_type_List.h"


@interface TLMyFiledTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *filedName;

@property (weak, nonatomic) IBOutlet UIImageView *selectimage;

@property (nonatomic,strong) NSArray *selectArray;



@end



@implementation TLMyFiledTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        }
    return self;
}

+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"myfiled";
    
    TLMyFiledTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle] loadNibNamed:@"TLMyFiledTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

-(NSArray *)selectArray
{
    if (_selectArray == nil) {
        _selectArray = [NSArray array];
    }
    return _selectArray;
}

-(void)setIsSelected:(BOOL)isSelected
{

    int  index = 0;

    self.selectimage.hidden = !isSelected;
    _isSelected = isSelected;
    
    self.selectArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectFiled"];
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.selectArray];
    
    
    if (isSelected == YES) {
        for (NSDictionary *dict in temp)
        {
            if ([dict[@"type_id"] isEqualToString:self.prod_type_List.type_id])
            {
                index = 1;
            }
        }
        
        if (index == 0) {
            [temp addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.prod_type_List.type_id,@"type_id",self.prod_type_List.type_name,@"type_name", nil]];
        }
        self.selectArray = temp;
    }else
    {
        
        [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if ([obj[@"type_id"] isEqualToString:self.prod_type_List.type_id]) {
                *stop = YES;
                if (*stop == YES) {
                    [temp removeObjectAtIndex:idx];
                }
            }
        }];
        
        self.selectArray = temp;
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.selectArray forKey:@"selectFiled"];

}

-(void)setProd_type_List:(TLProd_type_List *)prod_type_List
{
    
    int  index = 0;
    _prod_type_List = prod_type_List;
    self.filedName.text = prod_type_List.type_name;
    if (prod_type_List.sub_list.count != 0) {
        self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        self.accessoryType  = UITableViewCellAccessoryNone;
    }
    
    self.selectArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectFiled"];
    
    for (NSDictionary *dict in self.selectArray)
    {
        if ([dict[@"type_id"] isEqualToString:self.prod_type_List.type_id])
        {
            index = 1;
            break;
        }
    }
    if (index == 1) {
        self.isSelected = YES;
    }else
    {
        self.isSelected = NO;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
