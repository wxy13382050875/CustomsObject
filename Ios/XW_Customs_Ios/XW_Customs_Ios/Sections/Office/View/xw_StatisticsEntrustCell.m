//
//  xw_StatisticsEntrustCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_StatisticsEntrustCell.h"


@interface xw_StatisticsEntrustCell ()
@property(nonatomic,strong)UITextField* entrustOrgNameTextField;
@property(nonatomic,strong)UITextField* applyTextField;
@property(nonatomic,strong)UITextField* backTextField;
@property(nonatomic,strong)UITextField* waitAcceptTextField;
@property(nonatomic,strong)UITextField* acceptedTextField;
@property(nonatomic,strong)UITextField* doneTextField;
@end
@implementation xw_StatisticsEntrustCell
-(void)xw_setupUI{
    [self addSubview:self.entrustOrgNameTextField];
    [self addSubview:self.applyTextField];
    [self addSubview:self.backTextField];
    [self addSubview:self.waitAcceptTextField];
    [self addSubview:self.acceptedTextField];
    [self addSubview:self.doneTextField];
}
-(void)xw_updateConstraints{
    self.entrustOrgNameTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topEqualToView(self)
    .heightIs(30);
    
    self.applyTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.entrustOrgNameTextField, 0)
    .heightIs(30);
    
    self.backTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.applyTextField, 0)
    .heightIs(30);
    
    self.waitAcceptTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.backTextField, 0)
    .heightIs(30);
    
    self.acceptedTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.waitAcceptTextField, 0)
    .heightIs(30);
    
    self.doneTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.acceptedTextField, 0)
    .heightIs(30);
}
-(void)setModel:(xw_StatisticsEntrustModel *)model{

    self.entrustOrgNameTextField.text = model.entrustOrgName;
    self.applyTextField.text = model.apply;
    self.backTextField.text = model.back;
    self.waitAcceptTextField.text = model.waitAccept;
    self.acceptedTextField.text = model.accepted;
    self.doneTextField.text = model.done;
}

-(UITextField*)entrustOrgNameTextField{
    if(!_entrustOrgNameTextField){
        _entrustOrgNameTextField = [UITextField new];
        _entrustOrgNameTextField.font = FONT(13);
        _entrustOrgNameTextField.textColor = COLOR(@"#2C2C2B");
        _entrustOrgNameTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"委托单位名称:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _entrustOrgNameTextField.leftView = titleLabel;
        _entrustOrgNameTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _entrustOrgNameTextField;
}
-(UITextField*)applyTextField{
    if(!_applyTextField){
        _applyTextField = [UITextField new];
        _applyTextField.font = FONT(13);
        _applyTextField.textColor = COLOR(@"#2C2C2B");
        _applyTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"申请数";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _applyTextField.leftView = titleLabel;
        _applyTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _applyTextField;
}
-(UITextField*)backTextField{
    if(!_backTextField){
        _backTextField = [UITextField new];
        _backTextField.font = FONT(13);
        _backTextField.textColor = COLOR(@"#2C2C2B");
        _backTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"退回数";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _backTextField.leftView = titleLabel;
        _backTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _backTextField;
}
-(UITextField*)waitAcceptTextField{
    if(!_waitAcceptTextField){
        _waitAcceptTextField = [UITextField new];
        _waitAcceptTextField.font = FONT(13);
        _waitAcceptTextField.textColor = COLOR(@"#2C2C2B");
        _waitAcceptTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"待受理数:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _waitAcceptTextField.leftView = titleLabel;
        _waitAcceptTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _waitAcceptTextField;
}
-(UITextField*)acceptedTextField{
    if(!_acceptedTextField){
        _acceptedTextField = [UITextField new];
        _acceptedTextField.font = FONT(13);
        _acceptedTextField.textColor = COLOR(@"#2C2C2B");
        _acceptedTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"已受理数:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _acceptedTextField.leftView = titleLabel;
        _acceptedTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _acceptedTextField;
}
-(UITextField*)doneTextField{
    if(!_doneTextField){
        _doneTextField = [UITextField new];
        _doneTextField.font = FONT(13);
        _doneTextField.textColor = COLOR(@"#2C2C2B");
        _doneTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"受理完成数:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _doneTextField.leftView = titleLabel;
        _doneTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _doneTextField;
}
@end
