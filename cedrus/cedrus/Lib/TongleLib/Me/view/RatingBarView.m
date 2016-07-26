//
//  RatingBarView.m
//  CustomRatingBar
//
//  Created by jixiaofei-mac on 16/4/19.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import "RatingBarView.h"
#import "RatingBar.h"
#import "UIColor+TL.h"
#import "TLCommon.h"
#import "MBProgressHUD+MJ.h"

#define MAX_LIMIT_NUMS     100


@interface RatingBarView ()<RatingBarDelegate,UITextViewDelegate>

@property (nonatomic,strong) UILabel *mLabel;

@property (nonatomic,strong) RatingBar *ratingBar;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UITextView *comment;
@property (nonatomic,weak) UIButton *button;
@property (nonatomic,weak) UIButton *cancel;
@property (nonatomic,copy) NSString *estimation;

@end

@implementation RatingBarView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        RatingBar *ratingBar = [[RatingBar alloc] init];
        [self addSubview:ratingBar];
        _ratingBar = ratingBar;

        
        UILabel *title = [[UILabel alloc]init];
        [self addSubview:title];
        title.font = [UIFont systemFontOfSize:15];
        title.text = @"总体评价";
        _title = title;
        
        
        UITextView *comment = [[UITextView alloc]init];
        comment.backgroundColor = [UIColor getColor:@"f9f9f9"];
        comment.delegate = self;
        comment.font = [UIFont systemFontOfSize:12];
        [comment setTextColor:[UIColor getColor:@"464646"]];
        comment.layer.borderWidth = 0.8;
        comment.layer.borderColor = [[UIColor getColor:@"bcbcbc"]CGColor];
        [self addSubview:comment];
        _comment = comment;
        
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"确认" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor getColor:@"96d7fc"]];
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button = button;
        [self setButtonlayer:button];
        
        
        UIButton *cancel = [[UIButton alloc]init];
         [cancel setBackgroundColor:[UIColor getColor:@"d0d0d0"]];
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancel];
        [self setButtonlayer:cancel];
        _cancel = cancel;

    }
    return self;
}

-(void)setButtonlayer:(UIButton *)btn
{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:3.0]; //设置矩圆角半径
    [btn.layer setBorderWidth:1.0];   //边框宽度

    CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
    [btn.layer setBorderColor:colorref2];//边框颜色
}


-(void)layoutSubviews
{
    CGRect frame = self.frame;
    
    [super layoutSubviews];
    
    CGSize titlesize = [_title.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}];
    
    _title.bounds = CGRectMake(20, 20, titlesize.width, titlesize.height);
    
    
    CGFloat width = frame.size.width - 80- titlesize.width;
    
    _ratingBar.frame = CGRectMake(40+titlesize.width, 20, width, titlesize.height);
   
    _title.center = CGPointMake(20+titlesize.width/2, _ratingBar.center.y+5);
    _ratingBar.isIndicator = NO;
    [_ratingBar setImageDeselected:@"icon_star_nor_big" halfSelected:@"icon_star_press_big" fullSelected:@"icon_star_press_big" andDelegate:self];
    CGFloat width1 = frame.size.width - 40;
    
    _comment.frame = CGRectMake(20, CGRectGetMaxY(_ratingBar.frame)+20, width1, frame.size.height-110-CGRectGetMaxY(_ratingBar.frame));
    _cancel.frame = CGRectMake(frame.size.width/4-50, CGRectGetMaxY(_comment.frame)+30, 100, 30);
    _button.frame = CGRectMake(frame.size.width*3/4-50, CGRectGetMaxY(_comment.frame)+30, 100, 30);

}

-(void)action:(UIButton *)btn
{
    
    if ([_estimation intValue]) {
        if ([self.delegate respondsToSelector:@selector(ratingBarView:withEstimation:comment:groupOrder:)]) {
            [self.delegate ratingBarView:self withEstimation:_estimation comment:_comment.text groupOrder:_groupOrder];
        }
    }else
    {
        [MBProgressHUD showError:@"至少选择一分"];
    }
}


-(void)cancel:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(ratingBarViewCancel:)]) {
        [self.delegate ratingBarViewCancel:self];
    }
}



#pragma mark - RatingBar delegate
-(void)ratingBar:(RatingBar *)ratingBar ratingChanged:(float)newRating
{
    _estimation = [NSString stringWithFormat:@"%d",(int)newRating];

}


-(void)setGroupOrder:(TLGroupOrder *)groupOrder
{
    _groupOrder = groupOrder;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          NSInteger steplen = substring.length;
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx = idx + steplen;//这里变化了，使用了字串占的长度来作为步长
                                      }];
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
