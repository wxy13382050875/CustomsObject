//
//  xw_StatisticsAcceptCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_StatisticsAcceptCell.h"
@interface xw_StatisticsAcceptCell ()
@property(nonatomic,strong)UITextField* inspectOrgTextField;
@property(nonatomic,strong)UITextField* waitAcceptTextField;
@property(nonatomic,strong)UITextField* acceptedTextField;
@property(nonatomic,strong)UITextField* registeredTextField;
@property(nonatomic,strong)UITextField* reportTakedField;
@end
@implementation xw_StatisticsAcceptCell
-(void)xw_setupUI{
    [self addSubview:self.inspectOrgTextField];
    [self addSubview:self.waitAcceptTextField];
    [self addSubview:self.acceptedTextField];
    [self addSubview:self.registeredTextField];
    [self addSubview:self.reportTakedField];
}
-(void)xw_updateConstraints{
    self.inspectOrgTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topEqualToView(self)
    .heightIs(30);
    
    self.waitAcceptTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.inspectOrgTextField, 0)
    .heightIs(30);
    
    self.acceptedTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.waitAcceptTextField, 0)
    .heightIs(30);
    
    self.registeredTextField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.acceptedTextField, 0)
    .heightIs(30);
    
    self.reportTakedField.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .topSpaceToView(self.registeredTextField, 0)
    .heightIs(30);
}
-(void)setModel:(xw_StatisticsAcceptModel *)model{

    self.inspectOrgTextField.text = [xw_DataParsingHelper getSingleOrgsNameById: model.inspectOrgId];
    self.waitAcceptTextField.text = model.waitAccept;
    self.acceptedTextField.text = model.accepted;
    self.registeredTextField.text = model.registered;
    self.reportTakedField.text = model.reportTaked;
}

-(UITextField*)inspectOrgTextField{
    if(!_inspectOrgTextField){
        _inspectOrgTextField = [UITextField new];
        _inspectOrgTextField.font = FONT(13);
        _inspectOrgTextField.textColor = COLOR(@"#2C2C2B");
        _inspectOrgTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"检测机构";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _inspectOrgTextField.leftView = titleLabel;
        _inspectOrgTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _inspectOrgTextField;
}
-(UITextField*)waitAcceptTextField{
    if(!_waitAcceptTextField){
        _waitAcceptTextField = [UITextField new];
        _waitAcceptTextField.font = FONT(13);
        _waitAcceptTextField.textColor = COLOR(@"#2C2C2B");
        _waitAcceptTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"待受理数";
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
        titleLabel.text = @"已受理数";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _acceptedTextField.leftView = titleLabel;
        _acceptedTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _acceptedTextField;
}
-(UITextField*)registeredTextField{
    if(!_registeredTextField){
        _registeredTextField = [UITextField new];
        _registeredTextField.font = FONT(13);
        _registeredTextField.textColor = COLOR(@"#2C2C2B");
        _registeredTextField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"检测完成数";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _registeredTextField.leftView = titleLabel;
        _registeredTextField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _registeredTextField;
}
-(UITextField*)reportTakedField{
    if(!_reportTakedField){
        _reportTakedField = [UITextField new];
        _reportTakedField.font = FONT(13);
        _reportTakedField.textColor = COLOR(@"#2C2C2B");
        _reportTakedField.textAlignment = NSTextAlignmentRight;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"报告拿去数:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _reportTakedField.leftView = titleLabel;
        _reportTakedField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _reportTakedField;
}
@end
