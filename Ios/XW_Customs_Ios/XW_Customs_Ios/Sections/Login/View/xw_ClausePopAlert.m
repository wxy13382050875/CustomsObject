//
//  xw_ClausePopAlert.m
//  XW_Object
//
//  Created by Benc Mai on 2020/9/10.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_ClausePopAlert.h"
@interface xw_ClausePopAlert ()
@property (nonatomic, strong) UILabel *titleL ;
@property (nonatomic, strong) UILabel *detailL ;
@property (nonatomic, strong) UIButton *cancelB  ;
@property (nonatomic, strong) UIButton *knowB  ;
@property (nonatomic, copy) didChickEventBlock chickBlock;
@property (nonatomic, strong) xw_ClauseModel* model;
@end
@implementation xw_ClausePopAlert

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initPotAlert:(xw_ClauseModel*)model clickBlock:(didChickEventBlock) clickBlock{
    
    self.chickBlock = clickBlock;
    self.model = model;
    [self setupView];
    [self xw_setData];
    
}
-(void)setupView{
    ViewRadius(self, 10);
    [self addSubview:self.titleL];
    [self addSubview:self.detailL];
    [self addSubview:self.cancelB];
    [self addSubview:self.knowB];
    
    self.titleL.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .rightEqualToView(self)
    .heightIs(40);
    
    self.cancelB.sd_layout
    .leftEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(40).widthIs((SCREEN_WIDTH-50)/2);
    
    self.knowB.sd_layout
    .leftSpaceToView(self.cancelB, 0)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(40);
    
    self.detailL.sd_layout
    .leftSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .topSpaceToView(self.titleL, 0)
    .bottomSpaceToView(self.knowB, 0);
    
    // 横线
    UIView *line = [UIView new];
    line.backgroundColor =  COLOR(@"0xd9d9d9");
    [self addSubview:line];
    
    line.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    
    .bottomEqualToView(self.detailL)
    .heightIs(1);
}

-(void)xw_setData{
    
//    NSString * showText = @"我们更新了《用户协议》及《隐私政策》。用户协议作为边互通提供服务的依据，确定您在何种条件、以何种方式使用本网站及本网站的服务。隐私政策帮助您了解我们为什么么，以及如何收集、存储、使用、保护您的个人信息民。自2020年1月8号起，如果您继续使用边互通（包括App、网赠、小程序等）即表示您同意更新后的版本";
    
    CGSize size = [self.model.outline boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT(15)} context:nil].size;
    self.frame = CGRectMake(0, 0, size.width, size.height +150);
    
    NSMutableArray* arr = [NSMutableArray array];
    for (Protocols* tm in self.model.protocols) {
        [arr addObject:tm.name];
    }
    
    self.detailL.attributedText = [NSAttributedString getAttributeWith:arr  string:self.model.outline orginFont:FONT(15) orginColor:[UIColor darkGrayColor] attributeFont:FONT(15) attributeColor:[UIColor blueColor] textAlignment:NSTextAlignmentCenter];
    
    
    [self.detailL xw_addAttributeTapActionWithStrings:arr tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        
//        NSString * message = [NSString stringWithFormat:@"点击了\"%@\"字符\nrange:%@\n在数组中是第%ld个",string,NSStringFromRange(range),index + 1];
//        NSLog(@"%@",message);
        if (self.chickBlock) {
            self.chickBlock(self.model.protocols[index],0);
        }
    }];
    
    self.titleL.text = self.model.name;
}
-(UILabel*)titleL{
 
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:xwValue(16)];
//        _titleL.text = @"用户协议及隐私政策更新";
        _titleL.textColor = UIColor.blackColor;
        _titleL.textAlignment= NSTextAlignmentCenter;
        _titleL.backgroundColor = COLOR(@"#f5f5f5");
    }
    return _titleL;
}
-(UILabel*)detailL{
 
    if (!_detailL) {
        _detailL = [UILabel new];
        _detailL.numberOfLines = 0;
    }
    return _detailL;
}
-(UIButton*)knowB{
    if (!_knowB) {
        _knowB = [[UIButton alloc] init];
        [_knowB setTitle:@"同意" forState:UIControlStateNormal];
        [_knowB setTitleColor:COLOR(@"0xffffff") forState:UIControlStateNormal];
        [_knowB setBackgroundColor:COLOR(@"#1F7EFE")];
        [_knowB.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:xwValue(15)]];
        [_knowB addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _knowB;
}
-(UIButton*)cancelB{
    if (!_cancelB) {
        _cancelB = [[UIButton alloc] init];
        [_cancelB setTitle:@"不同意" forState:UIControlStateNormal];
        [_cancelB setTitleColor:COLOR(@"0xff3333") forState:UIControlStateNormal];
        [_cancelB setBackgroundColor:COLOR(@"#f5f5f5")];
        [_cancelB.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:xwValue(15)]];
        [_cancelB addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelB;
}
- (void)dismiss:(UIButton*)sender {
    if (self.chickBlock) {
        NSInteger type = 1;
        if (sender != self.cancelB) {
            type = 2;
        }
        self.chickBlock(nil,type);
    }
}

@end
