//
//  xw_ChangePwdTabCell.m
//  XW_Object
//
//  Created by Benc Mai on 2020/5/8.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_ChangePwdTabCell.h"
#import "xw_MyViewModel.h"

@interface xw_ChangePwdTabCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField* pwdTextField;
@property(nonatomic,strong)UITextField* npwdTextField;
@property(nonatomic,strong)UIButton* submitBtn;
@end
@implementation xw_ChangePwdTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)xw_setupUI{
    self.xw_height = SCREEN_HEIGHT - kNavBarAndStatusBarHeight - kBottomSafeHeight;
    [self.contentView addSubview:self.pwdTextField];
//    [self.contentView addSubview:self.npwdTextField];
    [self.contentView addSubview:self.submitBtn];
}
-(void)xw_updateConstraints{
    self.pwdTextField.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topEqualToView(self.contentView)
    .heightIs(40);
    
    UILabel* line = [UILabel labelWithLine:COLOR(@"#E5E5E5")];
    [self addSubview:line];
    line.sd_layout
    .leftEqualToView(self.pwdTextField)
    .rightEqualToView(self.pwdTextField)
    .bottomEqualToView(self.pwdTextField)
    .heightIs(1);
//
//    self.npwdTextField.sd_layout
//    .leftSpaceToView(self.contentView, 10)
//    .rightSpaceToView(self.contentView, 10)
//    .topSpaceToView(self.pwdTextField, 0)
//    .heightIs(40);
//
//    UILabel* line1 = [UILabel labelWithLine:COLOR(@"#E5E5E5")];
//    [self addSubview:line1];
//    line1.sd_layout
//    .leftEqualToView(self.npwdTextField)
//    .rightEqualToView(self.npwdTextField)
//    .bottomEqualToView(self.npwdTextField)
//    .heightIs(1);
    
    
    
    
    self.submitBtn.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.pwdTextField, 70)
    .heightIs(45).widthIs(160);
}
-(void)setViewMode:(id )viewMode{

    xw_MyViewModel* vModel = (xw_MyViewModel* )viewMode;
    RAC(vModel ,password) = self.pwdTextField.rac_textSignal;

}
#pragma mark 懒加载
-(UITextField*)pwdTextField{
    if (!_pwdTextField) {
        
        _pwdTextField = [UITextField textFieldWithtext:@"" WithTextColor:COLOR(@"#171717") WithFont:15 WithTextAlignment:NSTextAlignmentRight WithPlaceholder:@"请输入新密码" WithKeyWord:UIKeyboardTypeDefault WithDelegate:self];
        _pwdTextField.secureTextEntry = YES;
        UILabel* label = [UILabel labelWithText:@"新密码" WithTextColor:COLOR(@"#6B6B6B") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        label.frame = CGRectMake(0, 0, 80, 40);
        
        _pwdTextField.leftView = label;
        _pwdTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_textfield_edit");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(23).heightIs(23);
        _pwdTextField.rightView = rightView;
        _pwdTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _pwdTextField;
}
-(UITextField*)npwdTextField{
    if (!_npwdTextField) {
        
        _npwdTextField = [UITextField textFieldWithtext:@"" WithTextColor:COLOR(@"#171717") WithFont:15 WithTextAlignment:NSTextAlignmentRight WithPlaceholder:@"请输入新密码" WithKeyWord:UIKeyboardTypeDefault WithDelegate:self];
        _npwdTextField.secureTextEntry = YES;
        UILabel* label = [UILabel labelWithText:@"新密码" WithTextColor:COLOR(@"#6B6B6B") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        label.frame = CGRectMake(0, 0, 80, 40);
        
        _npwdTextField.leftView = label;
        _npwdTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_textfield_edit");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(23).heightIs(23);
        _npwdTextField.rightView = rightView;
        _npwdTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _npwdTextField;
}
-(UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithTitie:@"重置密码" WithtextColor:COLOR(@"#ffffff") WithBackColor:COLOR(@"#1F7EFE") WithBackImage:nil WithImage:nil WithFont:16 EventBlock:^(id  _Nonnull params) {
            if (self.didChickEventBlock) {
                self.didChickEventBlock(@"0");
            }
        }];

        ViewRadius(_submitBtn, 20);
    }
    return _submitBtn;
}
@end
