//
//  xw_PopAlert.m
//  XW_Object
//
//  Created by Benc Mai on 2021/2/1.
//  Copyright © 2021 武新义. All rights reserved.
//

#import "xw_PopAlert.h"

@interface xw_PopAlert ()
@property (nonatomic, strong) UITextField *titleL ;
@property (nonatomic, strong) UILabel *subTitleL ;
@property (nonatomic, strong) UITextView *content ;
@property (nonatomic, strong) UIButton *button  ;
@property (nonatomic, copy) didChickBlock chickBlock;


@property (nonatomic, strong) xw_PopAlertModel *model ;
@end
@implementation xw_PopAlert

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)initPopAlert:(xw_PopAlertModel*)model clickBlock:(didChickBlock) clickBlock{
    self.chickBlock = clickBlock;
    self.model = model;
    [self setupView];
    [self xw_setData];
}
-(void)setupView{
    ViewRadius(self, 10);
    [self addSubview:self.titleL];
    [self addSubview:self.subTitleL];
    [self addSubview:self.content];
    [self addSubview:self.button];
    
    self.titleL.sd_layout
    .leftSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .topEqualToView(self)
    .heightIs(40);
    
    self.subTitleL.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(self.titleL, 0)
    .rightEqualToView(self).heightIs(0);
    
    self.button.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(self, 10)
    .heightIs(40).widthIs(100);
    
    
    
    self.content.sd_layout
    .leftSpaceToView(self, 15)
    .rightSpaceToView(self, 15)
    .topSpaceToView(self.subTitleL, 0)
    .bottomSpaceToView(self.button, 0);
    
    
}

-(void)xw_setData{
    
//    NSString * showText = @"我们更新了《用户协议》及《隐私政策》。用户协议作为边互通提供服务的依据，确定您在何种条件、以何种方式使用本网站及本网站的服务。隐私政策帮助您了解我们为什么么，以及如何收集、存储、使用、保护您的个人信息民。自2020年1月8号起，如果您继续使用边互通（包括App、网赠、小程序等）即表示您同意更新后的版本";
    
   
    
    self.titleL.text = self.model.title;
    CGFloat heigth = 140;
    NSString* btnName = @"去认证";
    if (![self.model.type isEqualToString:@"REAL_PERSON"]) {
        self.subTitleL.text = @"互助委托书";
        self.subTitleL.sd_layout.heightIs(30);
        [self.subTitleL updateConstraints];
        heigth += 30;
        btnName = @"去委托";
    }
    
   
    
  
    [self.button setTitle:btnName forState:UIControlStateNormal];
    [self.button layoutWithStatus:XWLayoutStatusImageRight andMargin:5];
//    self.content.text = self.contentStr;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
     
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSString* content = [self.model.content stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
    self.content.attributedText = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
       self.frame = CGRectMake(0, 0, size.width, size.height + heigth);
    
}
-(UITextField*)titleL{
    if (!_titleL) {
        _titleL = [UITextField new];
        _titleL.font = FONT(15);
        _titleL.textColor = COLOR(@"#12B8F6");
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_pop_alert");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(25).heightIs(30);
        _titleL.leftView = leftView;
        
        _titleL.leftViewMode = UITextFieldViewModeAlways;
        _titleL.enabled = NO;
        
    }
    return _titleL;
}
-(UILabel*)subTitleL{
 
    if (!_subTitleL) {
        _subTitleL = [UILabel new];
        _subTitleL.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:xwValue(15)];
//        _titleL.text = @"用户协议及隐私政策更新";
        _subTitleL.textColor = UIColor.blackColor;
        _subTitleL.textAlignment= NSTextAlignmentCenter;
    }
    return _subTitleL;
}

-(UITextView*)content{
 
    if (!_content) {
        _content = [UITextView new];
        _content.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _content.scrollEnabled = NO;
        _content.font =FONT(15);
    }
    return _content;
}
-(UIButton*)button{
    if (!_button) {
        _button = [UIButton buttonWithTitie:@"" WithtextColor:[UIColor whiteColor]  WithBackColor:COLOR(@"#12B8F6") WithBackImage:nil WithImage:[UIImage imageNamed:@"icon_pop_btn"] WithFont:15 EventBlock:^(id  _Nonnull params) {
            if (self.chickBlock) {
            
                    self.chickBlock(self.model);
                }
        }];;
       
        
        ViewRadius(_button, 5);
    }
    return _button;
}



@end
