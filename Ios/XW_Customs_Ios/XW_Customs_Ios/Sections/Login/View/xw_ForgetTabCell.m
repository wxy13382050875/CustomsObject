//
//  xw_ForgetTabCell.m
//  XW_Object
//
//  Created by Benc Mai on 2019/11/27.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_ForgetTabCell.h"
#import "xw_LoginViewModel.h"
@interface xw_ForgetTabCell ()

@property(nonatomic,strong)UIView* topBgView;
@property(nonatomic,strong)UILabel* topTitleLabel;
@property(nonatomic,strong)UIButton* backBtn;

@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UITextField* phoneTextField;
@property(nonatomic,strong)UITextField* codeTextField;
@property(nonatomic,strong)UITextField* npwdTextField;
@property(nonatomic,strong)UIButton* resetBtn;

@property(nonatomic,strong)UIButton* codBtn;
@end
@implementation xw_ForgetTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)xw_setupUI{
    self.xw_height = SCREEN_HEIGHT;
    [self.contentView addSubview:self.topBgView];
    [self.topBgView addSubview:self.topTitleLabel];
    [self.topBgView addSubview:self.backBtn];
    
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    
    [self.bgView addSubview:self.phoneTextField];
    [self.bgView addSubview:self.codeTextField];
    [self.bgView addSubview:self.codBtn];
    [self.bgView addSubview:self.npwdTextField];
    
    [self.contentView addSubview:self.resetBtn];
}
-(void)xw_updateConstraints{
    
    self.backBtn.sd_layout
    .leftEqualToView(self.topBgView)
    .topSpaceToView(self.topBgView, kStatusBarHeight)
    .widthIs(kNavBarHeight)
    .heightIs(kNavBarHeight);
    
    self.topTitleLabel.sd_layout
    .leftSpaceToView(self.topBgView, kNavBarHeight)
    .rightSpaceToView(self.topBgView, kNavBarHeight)
    .topSpaceToView(self.topBgView, kStatusBarHeight)
    .heightIs(kNavBarHeight);
    
    
    
    self.bgView.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .topSpaceToView(self.contentView, kNavBarAndStatusBarHeight +10)
    .heightIs(260);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30)
    .topEqualToView(self.bgView)
    .heightIs(80);
    
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30)
    .topSpaceToView(self.titleLabel, 0)
    .heightIs(40);
    
    self.codeTextField.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30+120)
    .topSpaceToView(self.phoneTextField, 15)
    .heightIs(40);
    
    self.codBtn.sd_layout
    .rightSpaceToView(self.bgView, 30)
    .centerYEqualToView(self.codeTextField)
    .heightIs(40).widthIs(120);
    
    
    self.npwdTextField.sd_layout
    .leftSpaceToView(self.bgView, 30)
    .rightSpaceToView(self.bgView, 30)
    .topSpaceToView(self.codeTextField, 15)
    .heightIs(40);
    
    self.resetBtn.sd_layout
    .leftSpaceToView(self.contentView, 30)
    .rightSpaceToView(self.contentView, 30)
    .topSpaceToView(self.bgView, 45)
    .heightIs(47);
    
    
}

-(void)setViewMode:(xw_LoginViewModel* )viewMode{
//
    RAC(viewMode ,phone) = self.phoneTextField.rac_textSignal;
    RAC(viewMode ,smsCode) = self.codeTextField.rac_textSignal;
    RAC(viewMode ,password) = self.npwdTextField.rac_textSignal;
}
-(UIView*)topBgView{
    if (!_topBgView) {
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
        _topBgView.backgroundColor = COLOR(@"#206EEA");
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.topBgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(50,50 )];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

        maskLayer.frame = _topBgView.bounds;

        maskLayer.path = maskPath.CGPath;

        _topBgView.layer.mask = maskLayer;
    }
    return _topBgView;
}
-(UILabel*)topTitleLabel{
    if (!_topTitleLabel) {
        _topTitleLabel = [UILabel new];
        _topTitleLabel.text = @"忘记密码";
        _topTitleLabel.textAlignment= NSTextAlignmentCenter;
        _topTitleLabel.textColor = COLOR(@"#ffffff");
        _topTitleLabel.font = FONT(17);
    }
    return _topTitleLabel;
}

-(UIButton*)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:nil WithImage:IMG(@"back") WithFont:16 EventBlock:^(id  _Nonnull params) {
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"2");
            }
        }];
        
        ViewRadius(_backBtn, 17);
    }
    return _backBtn;
}
-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView addShadowToView:[UIColor blackColor]];
        [_bgView.layer setCornerRadius:5];
    }
    return _bgView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"忘记密码";
        _titleLabel.textColor = COLOR(@"#1F7EFE");
        _titleLabel.font = FONT(25);
    }
    return _titleLabel;
}

-(UITextField*)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [UITextField new];
        _phoneTextField.font = FONT(13);
        _phoneTextField.placeholder = @"请输入您的手机号";
        _phoneTextField.textColor = COLOR(@"#383838");
        _phoneTextField.backgroundColor = COLOR(@"#F5F5F5");
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_phone");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(13).heightIs(16);
        _phoneTextField.leftView = leftView;
        
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        @weakify(self);
        [[[_phoneTextField.rac_textSignal map:^id(NSString* value) {
            return @(value.length);
        }] filter:^BOOL(id value) {
            return [value intValue] > 11;
        }] subscribeNext:^(id x) {
            @strongify(self);
            self.phoneTextField.text = [self.phoneTextField.text substringToIndex:11];
        }];
        ViewRadius(_phoneTextField, 5);
    }
    return _phoneTextField;
}

-(UITextField*)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [UITextField new];
        _codeTextField.font = FONT(13);
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.textColor = COLOR(@"#383838");
        _codeTextField.backgroundColor = COLOR(@"#F5F5F5");
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_code");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(13).heightIs(16);
        
        _codeTextField.leftView = leftView;
        
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
//        ViewBorderRadius(_codeTextField, 3, 1, COLOR(@"#C5C5C5"));
        @weakify(self);
        [[[_codeTextField.rac_textSignal map:^id(NSString* value) {
            return @(value.length);
        }] filter:^BOOL(id value) {
            return [value intValue] > 6;
        }] subscribeNext:^(id x) {
            @strongify(self);
            self.codeTextField.text = [self.codeTextField.text substringToIndex:6];
        }];
        ViewRadius(_codeTextField, 5);
    }
    return _codeTextField;
}
-(UIButton*)codBtn{
    if (!_codBtn) {
        _codBtn = [UIButton buttonWithTitie:@"获取验证码" WithtextColor:[UIColor whiteColor]  WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:11 EventBlock:^(id  _Nonnull params) {
            if (self.phoneTextField.text.length < 11) {
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"身份证号输入不正确").wDisappelSecondSet(1).wStart();
                return ;
            }
            [params setCountdown:60];
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"1");
            }
        }];;
//        codBtn.frame = CGRectMake(0, 0, 118, 34);
        ViewRadius(_codBtn, 5);
    }
    return _codBtn;
}
-(UITextField*)npwdTextField{
    if (!_npwdTextField) {
        _npwdTextField = [UITextField new];
        _npwdTextField.font = FONT(15);
        _npwdTextField.placeholder = @"请输入密码";
        _npwdTextField.textColor = COLOR(@"#383838");
        _npwdTextField.backgroundColor = COLOR(@"#F5F5F5");
        _npwdTextField.secureTextEntry = YES;
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_pwd");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(13).heightIs(16);
        
        _npwdTextField.leftView = leftView;
        
        _npwdTextField.leftViewMode = UITextFieldViewModeAlways;
//        ViewBorderRadius(_npwdTextField, 3, 1, COLOR(@"#C5C5C5"));
        @weakify(self);
        [[[_npwdTextField.rac_textSignal map:^id(NSString* value) {
            return @(value.length);
        }] filter:^BOOL(id value) {
            return [value intValue] > 16;
        }] subscribeNext:^(id x) {
            @strongify(self);
            self.npwdTextField.text = [self.npwdTextField.text substringToIndex:11];
        }];
        ViewRadius(_resetBtn, 5);
    }
    return _npwdTextField;
}

-(UIButton*)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithTitie:@"下一步" WithtextColor:COLOR(@"#ffffff") WithBackColor:COLOR(@"#1F7EFE") WithBackImage:nil WithImage:nil WithFont:16 EventBlock:^(id  _Nonnull params) {
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"0");
            }
        }];
        
        ViewRadius(_resetBtn, 5);
    }
    return _resetBtn;
}


@end
