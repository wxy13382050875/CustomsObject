//
//  xw_DelegaetRegistCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/14.
//

#import "xw_DelegaetRegistCell.h"

@interface xw_DelegaetRegistCell ()<UITextFieldDelegate>


@property(nonatomic,strong)UILabel* typeLabel;
@property(nonatomic,strong)UITextField* typeTextField;

@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UITextField* nameTextField;

@property(nonatomic,strong)UILabel* papersNoLabel;
@property(nonatomic,strong)UITextField* papersNoTextField;

@property(nonatomic,strong)UILabel* addressLabel;
@property(nonatomic,strong)UITextField* addressTextField;

@property(nonatomic,strong)UILabel* contactsLabel;
@property(nonatomic,strong)UITextField* contactsTextField;

@property(nonatomic,strong)UILabel* phoneLabel;
@property(nonatomic,strong)UITextField* phoneTextField;

@property(nonatomic,strong)UILabel* faxLabel;
@property(nonatomic,strong)UITextField* faxTextField;

@property(nonatomic,strong)UILabel* emailLabel;
@property(nonatomic,strong)UITextField* emailTextField;
@end
@implementation xw_DelegaetRegistCell

-(void)xw_setupUI{
    self.xw_height= 480;
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.typeTextField];

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.nameTextField];

    [self.contentView addSubview:self.papersNoLabel];
    [self.contentView addSubview:self.papersNoTextField];

    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.addressTextField];
    
    [self.contentView addSubview:self.contactsLabel];
    [self.contentView addSubview:self.contactsTextField];

    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.phoneTextField];

    [self.contentView addSubview:self.faxLabel];
    [self.contentView addSubview:self.faxTextField];

    [self.contentView addSubview:self.emailLabel];
    [self.contentView addSubview:self.emailTextField];
}
-(void)xw_updateConstraints{
    
    self.typeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 15)
    .heightIs(35).widthIs(70);
    
    self.typeTextField.sd_layout
    .leftSpaceToView(self.typeLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.typeLabel)
    .heightIs(35);

    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.typeLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.nameTextField.sd_layout
    .leftSpaceToView(self.nameLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.nameLabel)
    .heightIs(35);

    self.papersNoLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.nameLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.papersNoTextField.sd_layout
    .leftSpaceToView(self.papersNoLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.papersNoLabel)
    .heightIs(35);
    
    self.addressLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.papersNoLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.addressTextField.sd_layout
    .leftSpaceToView(self.addressLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.addressLabel)
    .heightIs(35);
    
    self.contactsLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.addressTextField, 15)
    .heightIs(35).widthIs(70);
    
    self.contactsTextField.sd_layout
    .leftSpaceToView(self.contactsLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.contactsLabel)
    .heightIs(35);
    
    self.phoneLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contactsLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.phoneLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.phoneLabel)
    .heightIs(35);
    
    self.faxLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.phoneLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.faxTextField.sd_layout
    .leftSpaceToView(self.faxLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.faxLabel)
    .heightIs(35);
    
    self.emailLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.faxLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.emailTextField.sd_layout
    .leftSpaceToView(self.emailLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.emailLabel)
    .heightIs(35);

}

-(void)setModel:(xw_EntrustModel *)model{
    _model = model;
    
    self.typeTextField.text = _model.typeName;
    
    self.nameTextField.text = _model.name;

    self.papersNoTextField.text = _model.papersNo;

    self.addressTextField.text = _model.address;

    self.contactsTextField.text = _model.contacts;
    self.phoneTextField.text = _model.phone;
  
    self.faxTextField.text = _model.fax;

    self.emailTextField.text = _model.email;
  
}



-(UILabel*)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [UILabel labelWithText:@"企业类型" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _typeLabel;
}

-(UITextField*)typeTextField{
    if(!_typeTextField){
        _typeTextField = [UITextField new];
        _typeTextField.font = FONT(13);
        _typeTextField.textColor = COLOR(@"#171717");
        _typeTextField.textAlignment = NSTextAlignmentLeft;
        _typeTextField.placeholder = @"请输入样品名称";
        _typeTextField.backgroundColor = COLOR(@"#F5F5F5");
        
        
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);
        
        _typeTextField.rightView = rightView;
        _typeTextField.rightViewMode = UITextFieldViewModeAlways;
        _typeTextField.delegate = self;
        [_typeTextField setTextFieldLeftPadding:10];
        ViewRadius(_typeTextField, 5);
        
        @weakify(self);
        [_typeTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.typeName = x;
        }];
    }
    return _typeTextField;
}
-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithText:@"单位名称" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _nameLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"单位名称*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UITextField*)nameTextField{
    if(!_nameTextField){
        _nameTextField = [UITextField new];
        _nameTextField.font = FONT(13);
        _nameTextField.textColor = COLOR(@"#171717");
        _nameTextField.textAlignment = NSTextAlignmentLeft;
        _nameTextField.placeholder = @"请输入单位名称";
        _nameTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_nameTextField, 5);
        [_nameTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_nameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.name = x;
        }];
    }
    return _nameTextField;
}
-(UILabel*)papersNoLabel{
    if (!_papersNoLabel) {
        _papersNoLabel = [UILabel labelWithText:@"营业执照" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _papersNoLabel;
}

-(UITextField*)papersNoTextField{
    if(!_papersNoTextField){
        _papersNoTextField = [UITextField new];
        _papersNoTextField.font = FONT(13);
        _papersNoTextField.textColor = COLOR(@"#171717");
        _papersNoTextField.textAlignment = NSTextAlignmentLeft;
        _papersNoTextField.placeholder = @"请输入营业执照";
        _papersNoTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_papersNoTextField, 5);
        [_papersNoTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_papersNoTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.papersNo = x;
        }];
    }
    return _papersNoTextField;
}
-(UILabel*)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithText:@"地址" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _addressLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"地址*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    
    return _addressLabel;
}

-(UITextField*)addressTextField{
    if(!_addressTextField){
        _addressTextField = [UITextField new];
        _addressTextField.font = FONT(13);
        _addressTextField.textColor = COLOR(@"#171717");
        _addressTextField.textAlignment = NSTextAlignmentLeft;
        _addressTextField.placeholder = @"请输入地址";
        _addressTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_addressTextField, 5);
        [_addressTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_addressTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.address = x;
        }];
    }
    return _addressTextField;
}
-(UILabel*)contactsLabel{
    if (!_contactsLabel) {
        _contactsLabel = [UILabel labelWithText:@"联系人" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _contactsLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"联系人*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _contactsLabel;
}

-(UITextField*)contactsTextField{
    if(!_contactsTextField){
        _contactsTextField = [UITextField new];
        _contactsTextField.font = FONT(13);
        _contactsTextField.textColor = COLOR(@"#171717");
        _contactsTextField.textAlignment = NSTextAlignmentLeft;
        _contactsTextField.placeholder = @"请输入联系人";
        _contactsTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_contactsTextField, 5);
        [_contactsTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_contactsTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.contacts = x;
        }];
    }
    return _contactsTextField;
}
-(UILabel*)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel labelWithText:@"电话" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _phoneLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"电话*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _phoneLabel;
}

-(UITextField*)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [UITextField new];
        _phoneTextField.font = FONT(13);
        _phoneTextField.textColor = COLOR(@"#171717");
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.placeholder = @"请输入电话";
        _phoneTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_phoneTextField, 5);
        [_phoneTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_phoneTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.phone = x;
        }];
    }
    return _phoneTextField;
}
-(UILabel*)faxLabel{
    if (!_faxLabel) {
        _faxLabel = [UILabel labelWithText:@"传真" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _faxLabel;
}

-(UITextField*)faxTextField{
    if(!_faxTextField){
        _faxTextField = [UITextField new];
        _faxTextField.font = FONT(13);
        _faxTextField.textColor = COLOR(@"#171717");
        _faxTextField.textAlignment = NSTextAlignmentLeft;
        _faxTextField.placeholder = @"请输入传真";
        _faxTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_faxTextField, 5);
        [_faxTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_faxTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.fax = x;
        }];
    }
    return _faxTextField;
}
-(UILabel*)emailLabel{
    if (!_emailLabel) {
        _emailLabel = [UILabel labelWithText:@"邮箱" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        
    }
    return _emailLabel;
}

-(UITextField*)emailTextField{
    if(!_emailTextField){
        _emailTextField = [UITextField new];
        _emailTextField.font = FONT(13);
        _emailTextField.textColor = COLOR(@"#171717");
        _emailTextField.textAlignment = NSTextAlignmentLeft;
        _emailTextField.placeholder = @"请输入邮箱";
        _emailTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_emailTextField, 5);
        [_emailTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_emailTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.email = x;
        }];
    }
    return _emailTextField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.typeTextField ){
        [self showPick];
    }
    return NO;
}


-(void)showPick{
    NSArray* array = [xw_DataParsingHelper getDictPickList:@"ENTRUST_ORG_TYPE"];
    Dialog()
   .wTypeSet(DialogTypePickSelect)
   .wListDefaultValueSet(array[0][@"name"])  //默认
   .wEventOKFinishSet(^(id anyID, id otherData) {
          NSLog(@"%@",anyID[@"item"]);
       xw_DictModel* model = anyID[@"item"];
       self.typeTextField.text = model.name;
       self.model.type = model.code;
    })
   //一层直接传入带字典/字符串的数组 name为显示的文字 其他携带的model可以自由传入
   .wDataSet(array)
   .wStart();
}

@end
