//
//  xw_DelegateApplyCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/14.
//

#import "xw_DelegateApplyCell.h"
#import "RadioButton.h"
@interface xw_DelegateApplyCell ()<UITextFieldDelegate>


@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UITextField* nameTextField;

@property(nonatomic,strong)UILabel* addressLabel;
@property(nonatomic,strong)UITextField* addressTextField;

@property(nonatomic,strong)UILabel* contactsLabel;
@property(nonatomic,strong)UITextField* contactsTextField;

@property(nonatomic,strong)UILabel* phoneLabel;
@property(nonatomic,strong)UITextField* phoneTextField;

@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UITextField* sampleNameTextField;

@property(nonatomic,strong)UILabel* sampleNumLabel;
@property(nonatomic,strong)UITextField* sampleNumTextField;

@property(nonatomic,strong)UILabel* specLabel;
@property(nonatomic,strong)UITextField* specTextField;

@property(nonatomic,strong)UILabel* productionDateLabel;
@property(nonatomic,strong)UITextField* productionDateTextField;

@property(nonatomic,strong)UILabel* excStandardLabel;
@property(nonatomic,strong)UITextField* excStandardTextField;

@property(nonatomic,strong)UILabel* sampleMarkLabel;
@property(nonatomic,strong)UITextField* sampleMarkTextField;

@property(nonatomic,strong)UILabel* sampleQuantityLabel;
@property(nonatomic,strong)UITextField* sampleQuantityTextField;

@property(nonatomic,strong)UILabel* projectLabel;
@property(nonatomic,strong)UITextField* projectTextField;

@property(nonatomic,strong)UILabel* projectBasisLabel;
@property(nonatomic,strong)UITextField* projectBasisTextField;

@property(nonatomic,strong)UILabel* producerLabel;
@property(nonatomic,strong)UITextField* producerTextField;

@property(nonatomic,strong)UILabel* producerAddressLabel;
@property(nonatomic,strong)UITextField* producerAddressTextField;

@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UITextField* inspectOrgTextField;

@property(nonatomic,strong)UILabel* takeWayLabel;
@property(nonatomic,strong)UITextField* takeWayTextField;
@property(nonatomic,strong)NSMutableArray* buttons;

@end
@implementation xw_DelegateApplyCell

-(void)xw_setupUI{
    self.xw_height= 780;

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.nameTextField];

    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.addressTextField];

    [self.contentView addSubview:self.contactsLabel];
    [self.contentView addSubview:self.contactsTextField];

    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.phoneTextField];

    [self.contentView addSubview:self.sampleNameLabel];
    [self.contentView addSubview:self.sampleNameTextField];

    [self.contentView addSubview:self.sampleNumLabel];
    [self.contentView addSubview:self.sampleNumTextField];

    [self.contentView addSubview:self.specLabel];
    [self.contentView addSubview:self.specTextField];

    [self.contentView addSubview:self.productionDateLabel];
    [self.contentView addSubview:self.productionDateTextField];

    [self.contentView addSubview:self.excStandardLabel];
    [self.contentView addSubview:self.excStandardTextField];

    [self.contentView addSubview:self.sampleMarkLabel];
    [self.contentView addSubview:self.sampleMarkTextField];

    [self.contentView addSubview:self.sampleQuantityLabel];
    [self.contentView addSubview:self.sampleQuantityTextField];

    [self.contentView addSubview:self.projectLabel];
    [self.contentView addSubview:self.projectTextField];

    [self.contentView addSubview:self.projectBasisLabel];
    [self.contentView addSubview:self.projectBasisTextField];

    [self.contentView addSubview:self.producerLabel];
    [self.contentView addSubview:self.producerTextField];

    [self.contentView addSubview:self.producerAddressLabel];
    [self.contentView addSubview:self.producerAddressTextField];

    [self.contentView addSubview:self.inspectOrgLabel];
    [self.contentView addSubview:self.inspectOrgTextField];
    
    [self.contentView addSubview:self.takeWayLabel];
    [self.contentView addSubview:self.takeWayTextField];
}
-(void)xw_updateConstraints{
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 10)
    .heightIs(35).widthIs(70);
    
    self.nameTextField.sd_layout
    .leftSpaceToView(self.nameLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.nameLabel)
    .heightIs(35);

    self.addressLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.addressTextField.sd_layout
    .leftSpaceToView(self.addressLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.addressLabel)
    .heightIs(35);

    self.contactsLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.addressLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.contactsTextField.sd_layout
    .leftSpaceToView(self.contactsLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.contactsLabel)
    .heightIs(35);

    self.phoneLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contactsLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.phoneLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.phoneLabel)
    .heightIs(35);

    self.sampleNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.phoneLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.sampleNameTextField.sd_layout
    .leftSpaceToView(self.sampleNameLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sampleNameLabel)
    .heightIs(35);

    self.sampleNumLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.sampleNumTextField.sd_layout
    .leftSpaceToView(self.sampleNumLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sampleNumLabel)
    .heightIs(35);

    self.specLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNumLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.specTextField.sd_layout
    .leftSpaceToView(self.specLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.specLabel)
    .heightIs(35);

    self.productionDateLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.specLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.productionDateTextField.sd_layout
    .leftSpaceToView(self.productionDateLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.productionDateLabel)
    .heightIs(35);

    self.excStandardLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.productionDateLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.excStandardTextField.sd_layout
    .leftSpaceToView(self.excStandardLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.excStandardLabel)
    .heightIs(35);

    self.sampleMarkLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.excStandardLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.sampleMarkTextField.sd_layout
    .leftSpaceToView(self.sampleMarkLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sampleMarkLabel)
    .heightIs(35);

    self.sampleQuantityLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleMarkLabel, 10)
    .heightIs(35).widthIs(110);
    
    self.sampleQuantityTextField.sd_layout
    .leftSpaceToView(self.sampleQuantityLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sampleQuantityLabel)
    .heightIs(35);

    self.projectLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleQuantityLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.projectTextField.sd_layout
    .leftSpaceToView(self.projectLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.projectLabel)
    .heightIs(35);

    self.projectBasisLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.projectLabel, 10)
    .heightIs(35).widthIs(100);
    
    self.projectBasisTextField.sd_layout
    .leftSpaceToView(self.projectBasisLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.projectBasisLabel)
    .heightIs(35);

    self.producerLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.projectBasisLabel, 10)
    .heightIs(35).widthIs(70);
    
    self.producerTextField.sd_layout
    .leftSpaceToView(self.producerLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.producerLabel)
    .heightIs(35);

    self.producerAddressLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.producerLabel, 10)
    .heightIs(35).widthIs(90);
    
    self.producerAddressTextField.sd_layout
    .leftSpaceToView(self.producerAddressLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.producerAddressLabel)
    .heightIs(35);

    self.inspectOrgLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.producerAddressLabel, 15)
    .heightIs(35).widthIs(70);
    
    self.inspectOrgTextField.sd_layout
    .leftSpaceToView(self.inspectOrgLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.inspectOrgLabel)
    .heightIs(35);

    self.takeWayLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.inspectOrgLabel, 10)
    .heightIs(35).widthIs(130);
    
    self.takeWayTextField.sd_layout
    .leftSpaceToView(self.takeWayLabel, 20)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.takeWayLabel)
    .heightIs(35);
}

-(void)setModel:(xw_EntrustInspectModel *)model{
    _model = model;
    self.takeWayTextField.hidden = YES;
    xw_EntrustModel* enModel = [xw_EntrustModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].entrustOrg];
    self.nameTextField.text = enModel.name;
    self.addressTextField.text = enModel.address;
    self.contactsTextField.text = enModel.contacts;
    self.phoneTextField.text = enModel.phone;
    
    self.sampleNameTextField.text = _model.sampleName;
    self.sampleNumTextField.text = _model.sampleNum;
    self.specTextField.text = _model.spec;
    self.productionDateTextField.text = _model.productionDate;
    self.excStandardTextField.text = _model.excStandard;
    self.sampleMarkTextField.text = _model.sampleMark;
    
    self.sampleQuantityTextField.text = _model.sampleQuantity;
    self.projectTextField.text = _model.project;
    self.projectBasisTextField.text = _model.projectBasis;
    self.producerTextField.text = _model.producer;
    self.producerAddressTextField.text = _model.producerAddress;
    self.inspectOrgTextField.text = [xw_DataParsingHelper getSingleOrgsNameById:_model.inspectOrgId];
    
    
   
    
    [self.buttons removeAllObjects];
    NSArray* array = [xw_DataParsingHelper getDictItemByCode:@"TAKE_WAY"];
    NSInteger index = 0;
    for (int i = 0; i < array.count; i ++) {
        xw_DictModel* tm = array[i];
        RadioButton* radioBtn = [RadioButton new];
//        [radioBtn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        [radioBtn setTitle:tm.name forState:UIControlStateNormal];
        [radioBtn setTitleColor:COLOR(@"#2A2A2A") forState:UIControlStateNormal];
        radioBtn.titleLabel.font = FONT(13);
        [radioBtn setImage:[UIImage imageNamed:@"icon_radio_false.png"] forState:UIControlStateNormal];
        [radioBtn setImage:[UIImage imageNamed:@"icon_radio_true.png"] forState:UIControlStateSelected];
        radioBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        radioBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        radioBtn.tag = 10000 + i;
        @weakify(self);
        [[radioBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            RadioButton* button = x;
            xw_DictModel* tm = array[button.tag - 10000];
            self.model.takeWay = tm.code;

        }];
        [self.contentView addSubview:radioBtn];
        radioBtn.sd_layout
        .leftSpaceToView(self.takeWayLabel, i* 70 + 5)
        .centerYEqualToView(self.takeWayLabel)
        .widthIs(70).heightIs(35);
        [self.buttons addObject:radioBtn];
        if([self.model.takeWay isEqualToString:tm.code]){
            index = i;
        }
        
    }
    [self.buttons[0] setGroupButtons:self.buttons];
    
    if(self.model.takeWay != nil){
        [self.buttons[index] setSelected:YES];
    }
    
}
-(void)setDetailModel:(xw_EntrustInspectModel *)detailModel{
    _detailModel = detailModel;
    self.takeWayTextField.hidden = NO;
    xw_EntrustModel* enModel = [xw_EntrustModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].entrustOrg];
    self.nameTextField.text = enModel.name;
    
    self.addressTextField.text = enModel.address;
    self.contactsTextField.text = enModel.contacts;
    self.phoneTextField.text = enModel.phone;
    
    self.sampleNameTextField.text = _detailModel.sampleName;
    self.sampleNumTextField.text = _detailModel.sampleNum;
    self.specTextField.text = _detailModel.spec;
    self.productionDateTextField.text = _detailModel.productionDate;
    self.excStandardTextField.text = _detailModel.excStandard;
    self.sampleMarkTextField.text = _detailModel.sampleMark;
    
    self.sampleQuantityTextField.text = _detailModel.sampleQuantity;
    self.projectTextField.text = _detailModel.project;
    self.projectBasisTextField.text = _detailModel.projectBasis;
    self.producerTextField.text = _detailModel.producer;
    self.producerAddressTextField.text = _detailModel.producerAddress;
    self.inspectOrgTextField.text = [xw_DataParsingHelper getSingleOrgsNameById:_detailModel.inspectOrgId];
    self.takeWayTextField.text = [xw_DataParsingHelper GetDictNameBySubCode:@"TAKE_WAY" subCode:_detailModel.takeWay];
 
    
    
    self.nameTextField.textAlignment = NSTextAlignmentRight;
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.enabled = NO;
    self.nameTextField.placeholder = @"";
    
    self.addressTextField.textAlignment = NSTextAlignmentRight;
    self.addressTextField.backgroundColor = [UIColor whiteColor];
    self.addressTextField.enabled = NO;
    self.addressTextField.placeholder = @"";
    
    self.contactsTextField.textAlignment = NSTextAlignmentRight;
    self.contactsTextField.backgroundColor = [UIColor whiteColor];
    self.contactsTextField.enabled = NO;
    self.contactsTextField.placeholder = @"";
    
    self.phoneTextField.textAlignment = NSTextAlignmentRight;
    self.phoneTextField.backgroundColor = [UIColor whiteColor];
    self.phoneTextField.enabled = NO;
    self.phoneTextField.placeholder = @"";
    
    self.sampleNameTextField.textAlignment = NSTextAlignmentRight;
    self.sampleNameTextField.backgroundColor = [UIColor whiteColor];
    self.sampleNameTextField.enabled = NO;
    self.sampleNameTextField.placeholder = @"";
    
    self.sampleNumTextField.textAlignment = NSTextAlignmentRight;
    self.sampleNumTextField.backgroundColor = [UIColor whiteColor];
    self.sampleNumTextField.enabled = NO;
    self.sampleNumTextField.placeholder = @"";
    
    self.specTextField.textAlignment = NSTextAlignmentRight;
    self.specTextField.backgroundColor = [UIColor whiteColor];
    self.specTextField.enabled = NO;
    self.specTextField.placeholder = @"";
    
    self.productionDateTextField.textAlignment = NSTextAlignmentRight;
    self.productionDateTextField.backgroundColor = [UIColor whiteColor];
    self.productionDateTextField.enabled = NO;
    self.productionDateTextField.placeholder = @"";
    
    self.excStandardTextField.textAlignment = NSTextAlignmentRight;
    self.excStandardTextField.backgroundColor = [UIColor whiteColor];
    self.excStandardTextField.enabled = NO;
    self.excStandardTextField.placeholder = @"";
    
    self.sampleMarkTextField.textAlignment = NSTextAlignmentRight;
    self.sampleMarkTextField.backgroundColor = [UIColor whiteColor];
    self.sampleMarkTextField.enabled = NO;
    self.sampleMarkTextField.placeholder = @"";
    
    self.sampleQuantityTextField.textAlignment = NSTextAlignmentRight;
    self.sampleQuantityTextField.backgroundColor = [UIColor whiteColor];
    self.sampleQuantityTextField.enabled = NO;
    self.sampleQuantityTextField.placeholder = @"";
    
    self.projectTextField.textAlignment = NSTextAlignmentRight;
    self.projectTextField.backgroundColor = [UIColor whiteColor];
    self.projectTextField.enabled = NO;
    self.projectTextField.placeholder = @"";
    
    self.projectBasisTextField.textAlignment = NSTextAlignmentRight;
    self.projectBasisTextField.backgroundColor = [UIColor whiteColor];
    self.projectBasisTextField.enabled = NO;
    self.projectBasisTextField.placeholder = @"";
    
    self.producerTextField.textAlignment = NSTextAlignmentRight;
    self.producerTextField.backgroundColor = [UIColor whiteColor];
    self.producerTextField.enabled = NO;
    self.producerTextField.placeholder = @"";
    
    self.producerAddressTextField.textAlignment = NSTextAlignmentRight;
    self.producerAddressTextField.backgroundColor = [UIColor whiteColor];
    self.producerAddressTextField.enabled = NO;
    self.producerAddressTextField.placeholder = @"";
    
    self.inspectOrgTextField.textAlignment = NSTextAlignmentRight;
    self.inspectOrgTextField.backgroundColor = [UIColor whiteColor];
    self.inspectOrgTextField.enabled = NO;
    self.inspectOrgTextField.placeholder = @"";
    
    self.takeWayTextField.textAlignment = NSTextAlignmentRight;
    self.takeWayTextField.backgroundColor = [UIColor whiteColor];
    self.takeWayTextField.enabled = NO;
    self.takeWayTextField.placeholder = @"";
    

    self.productionDateTextField.rightViewMode = UITextFieldViewModeNever;
    
    self.inspectOrgTextField.rightViewMode = UITextFieldViewModeNever;
}


-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithText:@"委托单位" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _nameLabel;
}

-(UITextField*)nameTextField{
    if(!_nameTextField){
        _nameTextField = [UITextField new];
        _nameTextField.font = FONT(13);
        _nameTextField.textColor = COLOR(@"#171717");
        _nameTextField.textAlignment = NSTextAlignmentLeft;
        _nameTextField.placeholder = @"请输入委托单位";
        _nameTextField.backgroundColor = COLOR(@"#F5F5F5");
        _nameTextField.enabled = NO;
        [_nameTextField setTextFieldLeftPadding:10];
        ViewRadius(_nameTextField, 5);
    }
    return _nameTextField;
}
-(UILabel*)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [UILabel labelWithText:@"地址" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
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
        _addressTextField.enabled = NO;
        [_addressTextField setTextFieldLeftPadding:10];
        ViewRadius(_addressTextField, 5);
    }
    return _addressTextField;
}

-(UILabel*)contactsLabel{
    if (!_contactsLabel) {
        _contactsLabel = [UILabel labelWithText:@"联系人" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
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
        _contactsTextField.enabled = NO;
        [_contactsTextField setTextFieldLeftPadding:10];
        ViewRadius(_contactsTextField, 5);
    }
    return _contactsTextField;
}

-(UILabel*)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel labelWithText:@"电话" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
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
        _phoneTextField.enabled = NO;
        [_phoneTextField setTextFieldLeftPadding:10];
        ViewRadius(_phoneTextField, 5);
    }
    return _phoneTextField;
}

-(UILabel*)sampleNameLabel{
    if (!_sampleNameLabel) {
        _sampleNameLabel = [UILabel labelWithText:@"样品名称" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _sampleNameLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"样品名称*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _sampleNameLabel;
}

-(UITextField*)sampleNameTextField{
    if(!_sampleNameTextField){
        _sampleNameTextField = [UITextField new];
        _sampleNameTextField.font = FONT(13);
        _sampleNameTextField.textColor = COLOR(@"#171717");
        _sampleNameTextField.textAlignment = NSTextAlignmentLeft;
        _sampleNameTextField.placeholder = @"请输入样品名称";
        _sampleNameTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_sampleNameTextField, 5);
        @weakify(self);
        [_sampleNameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.sampleName = x;
        }];
        [_sampleNameTextField setTextFieldLeftPadding:10];
    }
    return _sampleNameTextField;
}

-(UILabel*)sampleNumLabel{
    if (!_sampleNumLabel) {
        _sampleNumLabel = [UILabel labelWithText:@"样品份数" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _sampleNumLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"样品份数*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _sampleNumLabel;
}

-(UITextField*)sampleNumTextField{
    if(!_sampleNumTextField){
        _sampleNumTextField = [UITextField new];
        _sampleNumTextField.font = FONT(13);
        _sampleNumTextField.textColor = COLOR(@"#171717");
        _sampleNumTextField.textAlignment = NSTextAlignmentLeft;
        _sampleNumTextField.placeholder = @"请输入样品份数";
        _sampleNumTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_sampleNumTextField, 5);
        @weakify(self);
        [_sampleNumTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.sampleNum = x;
        }];
        [_sampleNumTextField setTextFieldLeftPadding:10];
    }
    return _sampleNumTextField;
}

-(UILabel*)specLabel{
    if (!_specLabel) {
        _specLabel = [UILabel labelWithText:@"规格型号" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _specLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"规格型号*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _specLabel;
}

-(UITextField*)specTextField{
    if(!_specTextField){
        _specTextField = [UITextField new];
        _specTextField.font = FONT(13);
        _specTextField.textColor = COLOR(@"#171717");
        _specTextField.textAlignment = NSTextAlignmentLeft;
        _specTextField.placeholder = @"请输入规格型号";
        _specTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_specTextField, 5);
        @weakify(self);
        [_specTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.spec = x;
        }];
        [_specTextField setTextFieldLeftPadding:10];
    }
    return _specTextField;
}

-(UILabel*)productionDateLabel{
    if (!_productionDateLabel) {
        _productionDateLabel = [UILabel labelWithText:@"生产日期" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _productionDateLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"生产日期*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _productionDateLabel;
}

-(UITextField*)productionDateTextField{
    if(!_productionDateTextField){
        _productionDateTextField = [UITextField new];
        _productionDateTextField.font = FONT(13);
        _productionDateTextField.textColor = COLOR(@"#171717");
        _productionDateTextField.textAlignment = NSTextAlignmentLeft;
        _productionDateTextField.placeholder = @"请输入生产日期";
        _productionDateTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_productionDateTextField, 5);
        @weakify(self);
        [_productionDateTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.productionDate = x;
        }];
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);
        
        _productionDateTextField.rightView = rightView;
        _productionDateTextField.rightViewMode = UITextFieldViewModeAlways;
        _productionDateTextField.delegate = self;
        
        [_productionDateTextField setTextFieldLeftPadding:10];
    }
    return _productionDateTextField;
}

-(UILabel*)excStandardLabel{
    if (!_excStandardLabel) {
        _excStandardLabel = [UILabel labelWithText:@"执行标准" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _excStandardLabel;
}

-(UITextField*)excStandardTextField{
    if(!_excStandardTextField){
        _excStandardTextField = [UITextField new];
        _excStandardTextField.font = FONT(13);
        _excStandardTextField.textColor = COLOR(@"#171717");
        _excStandardTextField.textAlignment = NSTextAlignmentLeft;
        _excStandardTextField.placeholder = @"请输入执行标准";
        _excStandardTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_excStandardTextField, 5);
        @weakify(self);
        [_excStandardTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.excStandard = x;
        }];
        [_excStandardTextField setTextFieldLeftPadding:10];
    }
    return _excStandardTextField;
}

-(UILabel*)sampleMarkLabel{
    if (!_sampleMarkLabel) {
        _sampleMarkLabel = [UILabel labelWithText:@"样品标记" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _sampleMarkLabel;
}

-(UITextField*)sampleMarkTextField{
    if(!_sampleMarkTextField){
        _sampleMarkTextField = [UITextField new];
        _sampleMarkTextField.font = FONT(13);
        _sampleMarkTextField.textColor = COLOR(@"#171717");
        _sampleMarkTextField.textAlignment = NSTextAlignmentLeft;
        _sampleMarkTextField.placeholder = @"请输入样品标记";
        _sampleMarkTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_sampleMarkTextField, 5);
        @weakify(self);
        [_sampleMarkTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.sampleMark = x;
        }];
        [_sampleMarkTextField setTextFieldLeftPadding:10];
    }
    return _sampleMarkTextField;
}

-(UILabel*)sampleQuantityLabel{
    if (!_sampleQuantityLabel) {
        _sampleQuantityLabel = [UILabel labelWithText:@"样品数量/重量" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _sampleQuantityLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"样品数量/重量*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _sampleQuantityLabel;
}

-(UITextField*)sampleQuantityTextField{
    if(!_sampleQuantityTextField){
        _sampleQuantityTextField = [UITextField new];
        _sampleQuantityTextField.font = FONT(13);
        _sampleQuantityTextField.textColor = COLOR(@"#171717");
        _sampleQuantityTextField.textAlignment = NSTextAlignmentLeft;
        _sampleQuantityTextField.placeholder = @"请输入样品数量/重量";
        _sampleQuantityTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_sampleQuantityTextField, 5);
        @weakify(self);
        [_sampleQuantityTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.sampleQuantity = x;
        }];
        [_sampleQuantityTextField setTextFieldLeftPadding:10];
    }
    return _sampleQuantityTextField;
}

-(UILabel*)projectLabel{
    if (!_projectLabel) {
        _projectLabel = [UILabel labelWithText:@"检测项目" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _projectLabel;
}

-(UITextField*)projectTextField{
    if(!_projectTextField){
        _projectTextField = [UITextField new];
        _projectTextField.font = FONT(13);
        _projectTextField.textColor = COLOR(@"#171717");
        _projectTextField.textAlignment = NSTextAlignmentLeft;
        _projectTextField.placeholder = @"请输入检测项目";
        _projectTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_projectTextField, 5);
        @weakify(self);
        [_projectTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.project = x;
        }];
        [_projectTextField setTextFieldLeftPadding:10];
    }
    return _projectTextField;
}

-(UILabel*)projectBasisLabel{
    if (!_projectBasisLabel) {
        _projectBasisLabel = [UILabel labelWithText:@"检测项目依据" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _projectBasisLabel;
}

-(UITextField*)projectBasisTextField{
    if(!_projectBasisTextField){
        _projectBasisTextField = [UITextField new];
        _projectBasisTextField.font = FONT(13);
        _projectBasisTextField.textColor = COLOR(@"#171717");
        _projectBasisTextField.textAlignment = NSTextAlignmentLeft;
        _projectBasisTextField.placeholder = @"请输入检测项目依据";
        _projectBasisTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_projectBasisTextField, 5);
        @weakify(self);
        [_projectBasisTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.projectBasis = x;
        }];
        [_projectBasisTextField setTextFieldLeftPadding:10];
    }
    return _projectBasisTextField;
}

-(UILabel*)producerLabel{
    if (!_producerLabel) {
        _producerLabel = [UILabel labelWithText:@"生产商" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _producerLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"生产商*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _producerLabel;
}

-(UITextField*)producerTextField{
    if(!_producerTextField){
        _producerTextField = [UITextField new];
        _producerTextField.font = FONT(13);
        _producerTextField.textColor = COLOR(@"#171717");
        _producerTextField.textAlignment = NSTextAlignmentLeft;
        _producerTextField.placeholder = @"请输入生产商";
        _producerTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_producerTextField, 5);
        @weakify(self);
        [_producerTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.producer = x;
        }];
        [_producerTextField setTextFieldLeftPadding:10];
    }
    return _producerTextField;
}

-(UILabel*)producerAddressLabel{
    if (!_producerAddressLabel) {
        _producerAddressLabel = [UILabel labelWithText:@"生产商地址" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _producerAddressLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"生产商地址*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _producerAddressLabel;
}

-(UITextField*)producerAddressTextField{
    if(!_producerAddressTextField){
        _producerAddressTextField = [UITextField new];
        _producerAddressTextField.font = FONT(13);
        _producerAddressTextField.textColor = COLOR(@"#171717");
        _producerAddressTextField.textAlignment = NSTextAlignmentLeft;
        _producerAddressTextField.placeholder = @"请输入生产商地址";
        _producerAddressTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_producerAddressTextField, 5);
        @weakify(self);
        [_producerAddressTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.producerAddress = x;
        }];
        [_producerAddressTextField setTextFieldLeftPadding:10];
    }
    return _producerAddressTextField;
}

-(UILabel*)inspectOrgLabel{
    if (!_inspectOrgLabel) {
        _inspectOrgLabel = [UILabel labelWithText:@"检测机构" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _inspectOrgLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"检测机构*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _inspectOrgLabel;
}

-(UITextField*)inspectOrgTextField{
    if(!_inspectOrgTextField){
        _inspectOrgTextField = [UITextField new];
        _inspectOrgTextField.font = FONT(13);
        _inspectOrgTextField.textColor = COLOR(@"#171717");
        _inspectOrgTextField.textAlignment = NSTextAlignmentLeft;
        _inspectOrgTextField.placeholder = @"请输入检测机构";
        _inspectOrgTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_inspectOrgTextField, 5);
        @weakify(self);
        [_inspectOrgTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.inspectOrgId = x;
        }];
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);

        _inspectOrgTextField.rightView = rightView;
        _inspectOrgTextField.rightViewMode = UITextFieldViewModeAlways;
        _inspectOrgTextField.delegate = self;
        [_inspectOrgTextField setTextFieldLeftPadding:10];
    }
    return _inspectOrgTextField;
}



-(UILabel*)takeWayLabel{
    if (!_takeWayLabel) {
        _takeWayLabel = [UILabel labelWithText:@"检测报告拿取方式" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _takeWayLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"检测报告拿取方式*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _takeWayLabel;
}
-(UITextField*)takeWayTextField{
    if(!_takeWayTextField){
        _takeWayTextField = [UITextField new];
        _takeWayTextField.font = FONT(13);
        _takeWayTextField.textColor = COLOR(@"#171717");
        _takeWayTextField.textAlignment = NSTextAlignmentLeft;
        _takeWayTextField.placeholder = @"请输入生产商地址";
        _takeWayTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_takeWayTextField, 5);
        [_takeWayTextField setTextFieldLeftPadding:10];
    }
    return _takeWayTextField;
}
-(NSMutableArray*)buttons{
    if(!_buttons){
        _buttons = [NSMutableArray arrayWithCapacity:2];
    }
    return _buttons;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.productionDateTextField ){
        [self showCalander];
    }
    else if(textField == self.inspectOrgTextField){
        [self showPick];
    }
    return NO;
}


-(void)showCalander{
    Dialog()
    /// 隐藏农历
    .wOpenChineseDateSet(NO)
    /// 显示在底部
    .wMainToBottomSet(YES)
    .wTypeSet(DialogTypeCalander)
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        WMZCalanderModel* from = otherData;
        self.productionDateTextField.text = [formatter stringFromDate:from.wDate];;
        self.model.productionDate = [formatter stringFromDate:from.wDate];
    })
    .wStart();
}
-(void)showPick{
    NSArray* array = [xw_DataParsingHelper getOrgsSinglePickList];
    Dialog()
   .wTypeSet(DialogTypePickSelect)
   .wListDefaultValueSet(array[0][@"name"])  //默认
   .wEventOKFinishSet(^(id anyID, id otherData) {
          NSLog(@"%@",anyID[@"item"]);
       ChildrenModel* model = anyID[@"item"];
       self.inspectOrgTextField.text = model.name;
       self.model.inspectOrgId = model.id;
    })
   //一层直接传入带字典/字符串的数组 name为显示的文字 其他携带的model可以自由传入
   .wDataSet(array)
   .wStart();
}
@end
