//
//  TLEvaluationView.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-16.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLEvaluationView.h"
#import "TLProdEvaResult.h"
#import "UIColor+TL.h"

@interface TLEvaluationView ()

@property (weak, nonatomic) IBOutlet UIButton *Goodbutton;

@property (weak, nonatomic) IBOutlet UIButton *Wellbutton;

@property (weak, nonatomic) IBOutlet UIButton *Badbutton;

@property (weak, nonatomic) IBOutlet UITextView *comment;

- (IBAction)evaluationButton:(UIButton *)sender;

- (IBAction)cancel:(UIButton *)sender;

- (IBAction)submit:(UIButton *)sender;


@end


@implementation TLEvaluationView



-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self.Goodbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.Wellbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.Badbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    TLProdEvaResult *prodEvaResult = [[TLProdEvaResult alloc]init];
    self.prodEvaResult = prodEvaResult;
    
    self.prodEvaResult.selectEvalition = @"好评";
    return self;
}

+(id)evaluationView
{
    TLEvaluationView *view = [[[NSBundle mainBundle]loadNibNamed:@"TLEvaluationView" owner:self options:nil]lastObject];
    view.Goodbutton.selected = YES;

    view.Goodbutton.backgroundColor = [UIColor getColor:@"ffb408"];
    return view;
}


- (IBAction)evaluationButton:(UIButton *)sender
{
    [self cancelSelect];
    self.prodEvaResult.selectEvalition = [sender titleForState:UIControlStateNormal];

    sender.selected = YES;
    sender.backgroundColor = [UIColor getColor:@"ffb408"];
}

-(void)cancelSelect
{
    self.Goodbutton.selected = NO;
    self.Goodbutton.backgroundColor = [UIColor whiteColor];
    
    self.Wellbutton.selected = NO;
    self.Wellbutton.backgroundColor = [UIColor whiteColor];
    
    self.Badbutton.selected = NO;
    self.Badbutton.backgroundColor = [UIColor whiteColor];

}

- (IBAction)cancel:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(evaluationViewCancel:)]) {
        [self.delegate evaluationViewCancel:self];
    }
}

- (IBAction)submit:(UIButton *)sender
{
    self.prodEvaResult.evalitionContent = self.comment.text;
    
    
    if ([self.delegate respondsToSelector:@selector(evaluationViewSure:withProdEvaResult:)]) {
        [self.delegate evaluationViewSure:self withProdEvaResult:self.prodEvaResult];
    }
    
}
@end
