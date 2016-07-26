//
//  TLOrderFootViewCell.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-2.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLOrderFootViewCell.h"
#import "TLBasicData.h"
#import "TLBaseDateType.h"
#import "TLDataList.h"
#import "TLBaseDateType.h"
#import "TLButton.h"
#import "TLOrderMode.h"
#import "UIColor+TL.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "TLOrderLastView.h"
#import "TLOrderDetailMeg.h"
#import "UIButton+TL.h"

@interface TLOrderFootViewCell ()<UITextViewDelegate>

@property (nonatomic,strong) TLBaseDateType *payType;
@property (nonatomic,strong) TLBaseDateType *payInvoiceType;
@property (nonatomic,strong) TLBaseDateType *payInvoiceContent;
@property (nonatomic,copy) NSString         *pay_type;
@property (nonatomic,copy) NSString         *invoice_type;
@property (nonatomic,copy) NSString         *invoiceContent_type;
@property (nonatomic,weak) UITextField      *invoice_title;
@property (nonatomic,weak) UITextView       *order_memo;
@property (nonatomic,weak) UIButton         *sureButton;
@property (nonatomic,weak) UIButton         *noInvoiceButton;
@property (nonatomic,weak) UILabel          *noInvoiceLabel;
@property (nonatomic,weak) UIButton         *needInvoiceButton;
@property (nonatomic,weak) UILabel          *needInvoiceLabel;
@property (nonatomic,weak) UIView           *dividing_line_head;
@property (nonatomic,weak) UIView           *dividing_line_foot;
@property (nonatomic,weak) UILabel          *account;


@property (nonatomic,weak) UILabel          *remakes;
@property (nonatomic,weak) UIImageView *imageView1;
@property (nonatomic,weak) UILabel          *amount;

@property (nonatomic,weak) TLOrderLastView *orderLastView1;
@property (nonatomic,weak) TLOrderLastView *orderLastView2;
@property (nonatomic,weak) TLOrderLastView *orderLastView3;
@property (nonatomic,weak) TLOrderLastView *orderLastView4;
@property (nonatomic,weak) TLOrderLastView *orderLastView5;

@end


#define MAX_LIMIT_NUMS     50



@implementation TLOrderFootViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *remakes = [[UILabel alloc]init];
        remakes.text  = @"备注";
        [remakes setTextColor:[UIColor getColor:@"5f646e"]];
        remakes.font = [UIFont systemFontOfSize:12];
         [self.contentView addSubview:remakes];
        _remakes = remakes;
        
        UITextView *remakesText = [[UITextView alloc]init];
        remakesText.delegate = self;
        remakesText.font = [UIFont systemFontOfSize:12];
        [remakesText setTextColor:[UIColor getColor:@"464646"]];
        remakesText.layer.borderWidth = 0.8;
        remakesText.layer.borderColor = [[UIColor getColor:@"d9d9d9"]CGColor];
        [self.contentView addSubview:remakesText];
        _order_memo = remakesText;
        
        UILabel *dividing_line_head = [[UILabel alloc]init];
        dividing_line_head.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self.contentView addSubview:dividing_line_head];
        _dividing_line_head = dividing_line_head;
        
        UILabel *account = [[UILabel alloc]init];
        account.font = [UIFont systemFontOfSize:15];
        account.textColor = [UIColor blackColor];
        account.text = @"结算";
        [self.contentView addSubview:account];
        _account = account;
        
        UIImageView *imageView1 = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView1];
        _imageView1 = imageView1;
        
        UILabel *dividing_line_foot = [[UILabel alloc]init];
        dividing_line_foot.backgroundColor = [UIColor getColor:@"d9d9d9"];
        [self.contentView addSubview:dividing_line_foot];
        _dividing_line_foot = dividing_line_foot;
        
        
        UIButton *sureButton = [[UIButton alloc]init];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [sureButton setTintColor:[UIColor getColor:@"ffffff"]];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        sureButton.backgroundColor = [UIColor getColor:@"73c6f7"];
        [self.contentView addSubview:sureButton];
        [sureButton addTarget:self action:@selector(sureOrder:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton = sureButton;
        
        UILabel *amount = [[UILabel alloc]init];
        amount.font = [UIFont systemFontOfSize:16];
        amount.textColor = [UIColor getColor:@"73c6f7"];
        amount.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:amount];
        _amount = amount;
        
        TLOrderLastView *orderLastView1 = [[TLOrderLastView alloc]init];
        [self.contentView addSubview:orderLastView1];
        _orderLastView1 = orderLastView1;
        
        TLOrderLastView *orderLastView2 = [[TLOrderLastView alloc]init];
        [self.contentView addSubview:orderLastView2];
        _orderLastView2 = orderLastView2;
        
        TLOrderLastView *orderLastView3 = [[TLOrderLastView alloc]init];
        [self.contentView addSubview:orderLastView3];
        _orderLastView3 = orderLastView3;
        
        TLOrderLastView *orderLastView4 = [[TLOrderLastView alloc]init];
        [self.contentView addSubview:orderLastView4];
        _orderLastView4 = orderLastView4;
        
        TLOrderLastView *orderLastView5 = [[TLOrderLastView alloc]init];
        [self.contentView addSubview:orderLastView5];
        _orderLastView5 = orderLastView5;
    }
    return self;
    
}


-(void)setBaseData:(TLBasicData *)baseData
{

        _baseData = baseData;

        CGSize remakesSize = [_remakes.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        CGFloat remakesX = 13;
        CGFloat remakesY = 20;
        _remakes.frame = (CGRect){{remakesX,remakesY},remakesSize};
        
        CGFloat remakesTextX = remakesX;
        CGFloat remakesTextY = CGRectGetMaxY(_remakes.frame)+10;
        CGFloat remakesTextH = 32;
        CGFloat remakesTextW = ScreenBounds.size.width-20;
        _order_memo.frame = CGRectMake(remakesTextX, remakesTextY, remakesTextW, remakesTextH);
    
        _dividing_line_head.frame = CGRectMake(0, CGRectGetMaxY(_order_memo.frame)+5, ScreenBounds.size.width, 1);
    
        _account.frame = (CGRect){{remakesTextX,CGRectGetMaxY(_dividing_line_head.frame)+5},[_account.text sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}]};
        
        
        _imageView1.frame = CGRectMake(10,CGRectGetMaxY(_account.frame)-10, ScreenBounds.size.width-20, 20);
        
        UIGraphicsBeginImageContext(_imageView1.frame.size);   //开始画线
        [_imageView1.image drawInRect:CGRectMake(0, 0, _imageView1.frame.size.width, _imageView1.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        
        CGFloat lengths[] = {10,5};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, [UIColor getColor:@"d9d9d9"].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
        CGContextAddLineToPoint(line, ScreenBounds.size.width-20, 20.0);
        CGContextStrokePath(line);
        
        _imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
    
        
        [_orderLastView1 viewWithHeadTitle:@"商品总计" withFootTitle:self.orderDetailMeg.total_goods_price withFrame:CGRectMake(0,CGRectGetMaxY(_account.frame)+10,ScreenBounds.size.width, 30)];
        
        [_orderLastView2 viewWithHeadTitle:@"运费" withFootTitle:self.orderDetailMeg.total_fee withFrame:CGRectMake(0,CGRectGetMaxY(_orderLastView1.frame),ScreenBounds.size.width, 30)];

        
        [_orderLastView3 viewWithHeadTitle:@"关税" withFootTitle:self.orderDetailMeg.total_tariff withFrame:CGRectMake(0,CGRectGetMaxY(_orderLastView2.frame),ScreenBounds.size.width, 30)];

        
        [_orderLastView4 viewWithHeadTitle:@"抵用券" withFootTitle:self.couponmoney withFrame:CGRectMake(0,CGRectGetMaxY(_orderLastView3.frame),ScreenBounds.size.width, 30)];

        float lastmoney = [self.orderDetailMeg.total_goods_price floatValue]- [self.couponmoney floatValue];
        
        [_orderLastView5 viewWithHeadTitle:@"应付总额" withFootTitle:[NSString stringWithFormat:@"%.2f",lastmoney] withFrame:CGRectMake(0,CGRectGetMaxY(_orderLastView4.frame),ScreenBounds.size.width, 30)];
    
        _dividing_line_foot.frame = CGRectMake(0, CGRectGetMaxY(_orderLastView5.frame)+5, ScreenBounds.size.width, 1);

        
        _sureButton.frame = CGRectMake(ScreenBounds.size.width-100, CGRectGetMaxY(_dividing_line_foot.frame), 100, 48);

        _amount.text = [NSString stringWithFormat:@"合计:%.2f",lastmoney];
        _amount.frame = CGRectMake(0, self.sureButton.frame.origin.y, ScreenBounds.size.width-20-self.sureButton.frame.size.width, self.sureButton.frame.size.height);

    self.noInvoiceButton.selected = NO;
    [self noInvoiceButton:self.noInvoiceButton];
}


-(void)noInvoiceButton:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        self.needInvoiceButton.selected = NO;
        [self selectNoInvoice];
    }else
    {
        self.needInvoiceButton.selected = YES;
        [self selectNeedInvoice];
    }
}

-(void)selectNeedInvoice
{
    UIButton *button = (UIButton *)[self.contentView viewWithTag:(1100)];
    [self selectPay:button];
    
    button = (UIButton *)[self.contentView viewWithTag:(1200)];
    [self selectPayContent:button];
    self.invoice_title.enabled = YES;
}

-(void)selectNoInvoice
{
    for (int i = 0; i < self.payInvoiceType.data_list.count; i++)
    {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:(1100+i)];
        button.selected = NO;
        button.enabled = NO;
    }
    for (int i = 0; i < self.payInvoiceContent.data_list.count; i++)
    {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:(1200+i)];
        button.selected = NO;
        button.enabled = NO;
    }
    self.invoice_type = @"";
    self.invoiceContent_type = @"";
    self.invoice_title.text = @"";
    self.invoice_title.enabled = NO;
}

-(void)needInvoiceButton:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        self.noInvoiceButton.selected = NO;
        [self selectNeedInvoice];
    }else
    {
        self.noInvoiceButton.selected = YES;
        [self selectNoInvoice];
    }
}
-(void)payTypeButton:(UIButton *)button
{
    for (int i = 0; i < self.payType.data_list.count; i++)
    {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:(1000+i)];
        button.selected = NO;
        CGColorRef colorref2 = [UIColor getColor:@"d7d7d7"].CGColor;
        [button.layer setBorderColor:colorref2];//边框颜色
    }
    button.selected = YES;
    CGColorRef colorref2 = [UIColor getColor:@"ff0000"].CGColor;
    [button.layer setBorderColor:colorref2];//边框颜色

    int index = (int)(button.tag-1000);
    TLDataList *data = self.payType.data_list[index];
    self.pay_type = data.code;

}

-(void)sureOrder:(UIButton *)btn
{
    [btn ButtonDelay];
    
    TLOrderMode *ordermoder = [[TLOrderMode alloc]init];
    
    NSDictionary *Invoice_info = [NSDictionary dictionaryWithObjectsAndKeys:self.invoice_type,@"invoice_type_no",self.invoiceContent_type,@"invoice_content_flag",self.invoice_title.text,@"invoice_title", nil];
    
    ordermoder.pay_type = self.pay_type;
    ordermoder.order_memo = self.order_memo.text;
    ordermoder.invoice_info = Invoice_info;
    self.orderMode = ordermoder;
    
    if ([self.delegate respondsToSelector:@selector(orderFootViewCell:withOrderMode:)]) {
        [self.delegate orderFootViewCell:self withOrderMode:self.orderMode];
    }
}

-(void)setOrderDetailMeg:(TLOrderDetailMeg *)orderDetailMeg
{
    _orderDetailMeg = orderDetailMeg;
}

-(void)setCouponmoney:(NSString *)couponmoney
{
    _couponmoney = couponmoney;
}

-(void)selectPay:(UIButton *)btn
{
    for (int i = 0; i < self.payInvoiceType.data_list.count; i++)
    {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:(1100+i)];
        button.selected = NO;
        button.enabled = YES;
    }
    btn.selected = YES;
    int index = (int)(btn.tag-1100);
    TLDataList *data = self.payInvoiceType.data_list[index];
    self.invoice_type = data.code;
}

-(void)selectPayContent:(UIButton *)btn
{
    for (int i = 0; i < self.payInvoiceContent.data_list.count; i++)
    {
        UIButton *button = (UIButton *)[self.contentView viewWithTag:(1200+i)];
        button.selected = NO;
        button.enabled = YES;
    }
    btn.selected = YES;
    int index = (int)(btn.tag-1200);
    TLDataList *data = self.payInvoiceContent.data_list[index];
    self.invoiceContent_type = data.code;
}

+(instancetype)cellWithTableView:(UITableView *)table
{
    static NSString *ID = @"orderfoot";
    TLOrderFootViewCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
       cell = [[TLOrderFootViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
   }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.contentView endEditing:YES];
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


@end
