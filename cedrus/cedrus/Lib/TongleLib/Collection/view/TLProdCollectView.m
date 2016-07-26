//
//  TLProdCollectView.m
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdCollectView.h"
#import "TLImageName.h"



@interface TLProdCollectView ()

@property (weak, nonatomic) IBOutlet UIButton *meCollectBtn;

@property (weak, nonatomic) IBOutlet UIButton *meBodyBtn;

- (IBAction)myCollect:(UIButton *)sender;

- (IBAction)myBody:(UIButton *)sender;

- (IBAction)canelBtn:(UIButton *)sender;

- (IBAction)sureBtn:(UIButton *)sender;



@end


@implementation TLProdCollectView



+(instancetype)prodCollect
{
    return [[NSBundle mainBundle] loadNibNamed:@"TLProdCollectView" owner:self options:nil][0];
}

-(void)layoutSubviews
{
    [self.meCollectBtn setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_NORMAL] forState:UIControlStateNormal];
    [self.meCollectBtn setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_PRESS] forState:UIControlStateSelected];
    
    
    [self.meBodyBtn setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_NORMAL] forState:UIControlStateNormal];
    [self.meBodyBtn setBackgroundImage:[UIImage imageNamed:TL_CHECK_BOX_PRESS] forState:UIControlStateSelected];
}




- (IBAction)myCollect:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)myBody:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)canelBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ProdCollectViewCancelWithCollect:baby:)]) {
        [self.delegate ProdCollectViewCancelWithCollect:self.meCollectBtn.selected baby:self.meBodyBtn.selected];
    }
}

- (IBAction)sureBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(ProdCollectViewSureWithCollect:baby:)]) {
        [self.delegate ProdCollectViewSureWithCollect:self.meCollectBtn.selected baby:self.meBodyBtn.selected];
    }
}
@end
