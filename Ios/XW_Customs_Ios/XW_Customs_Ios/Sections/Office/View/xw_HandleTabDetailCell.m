//
//  xw_HandleTabDetailCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_HandleTabDetailCell.h"
#import "xw_UserInfoModel.h"
@interface xw_HandleTabDetailCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UITextField* snTextField;

@property(nonatomic,strong)UILabel* sourceLabel;
@property(nonatomic,strong)UITextField* sourceTextField;

@property(nonatomic,strong)UILabel* busCategoryLabel;
@property(nonatomic,strong)UITextField* busCategoryTextField;

@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UITextField* inspectOrgTextField;

@property(nonatomic,strong)UILabel* nameLabel;
@property(nonatomic,strong)UITextField* nameTextField;

@property(nonatomic,strong)UILabel* phoneLabel;
@property(nonatomic,strong)UITextField* phoneTextField;

@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UITextField* sampleNameTextField;

@property(nonatomic,strong)UILabel* sampleNumLabel;
@property(nonatomic,strong)UITextField* sampleNumTextField;

@property(nonatomic,strong)UILabel* specLabel;
@property(nonatomic,strong)UITextField* specTextField;

@property(nonatomic,strong)UILabel* excStandardLabel;
@property(nonatomic,strong)UITextField* excStandardTextField;

@property(nonatomic,strong)UILabel* projectLabel;
@property(nonatomic,strong)UITextField* projectTextField;

@property(nonatomic,strong)UILabel* projectBasisLabel;
@property(nonatomic,strong)UITextField* projectBasisTextField;

@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UITextField* createTimeTextField;

@property(nonatomic,strong)UILabel* producerAddressLabel;
@property(nonatomic,strong)UITextField* producerAddressTextField;

@property(nonatomic,strong)UILabel* takeWayLabel;
@property(nonatomic,strong)UITextField* takeWayTextField;

@property(nonatomic,strong)UILabel* acceptUserNameLabel;
@property(nonatomic,strong)UITextField* acceptUserNameTextField;

@property(nonatomic,strong)UILabel* acceptUserPhoneLabel;
@property(nonatomic,strong)UITextField* acceptUserPhoneTextField;

@property(nonatomic,strong)UILabel* acceptTimeLabel;
@property(nonatomic,strong)UITextField* acceptTimeTextField;

@end
@implementation xw_HandleTabDetailCell

-(void)xw_setupUI{
    self.xw_height= 720;

    [self.contentView addSubview:self.snLabel];
    [self.contentView addSubview:self.snTextField];

    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.sourceTextField];

    [self.contentView addSubview:self.busCategoryLabel];
    [self.contentView addSubview:self.busCategoryTextField];

    [self.contentView addSubview:self.inspectOrgLabel];
    [self.contentView addSubview:self.inspectOrgTextField];

    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.nameTextField];

    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.phoneTextField];

    [self.contentView addSubview:self.sampleNameLabel];
    [self.contentView addSubview:self.sampleNameTextField];

    [self.contentView addSubview:self.sampleNumLabel];
    [self.contentView addSubview:self.sampleNumTextField];

    [self.contentView addSubview:self.specLabel];
    [self.contentView addSubview:self.specTextField];

    [self.contentView addSubview:self.excStandardLabel];
    [self.contentView addSubview:self.excStandardTextField];

    [self.contentView addSubview:self.projectLabel];
    [self.contentView addSubview:self.projectTextField];

    [self.contentView addSubview:self.projectBasisLabel];
    [self.contentView addSubview:self.projectBasisTextField];

    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.createTimeTextField];

    [self.contentView addSubview:self.producerAddressLabel];
    [self.contentView addSubview:self.producerAddressTextField];

    [self.contentView addSubview:self.takeWayLabel];
    [self.contentView addSubview:self.takeWayTextField];

    [self.contentView addSubview:self.acceptUserNameLabel];
    [self.contentView addSubview:self.acceptUserNameTextField];

    [self.contentView addSubview:self.acceptUserPhoneLabel];
    [self.contentView addSubview:self.acceptUserPhoneTextField];

    [self.contentView addSubview:self.acceptTimeLabel];
    [self.contentView addSubview:self.acceptTimeTextField];
}
-(void)xw_updateConstraints{
    
    self.snLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 5)
    .heightIs(35).widthIs(100);
    
    self.snTextField.sd_layout
    .leftSpaceToView(self.snLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.snLabel)
    .heightIs(35);
    
    self.sourceLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.snLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.sourceTextField.sd_layout
    .leftSpaceToView(self.sourceLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sourceLabel)
    .heightIs(35);
    
    self.busCategoryLabel.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.sourceLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.busCategoryTextField.sd_layout
    .leftSpaceToView(self.busCategoryLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.busCategoryLabel)
    .heightIs(35);
    
    self.inspectOrgLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.busCategoryLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.inspectOrgTextField.sd_layout
    .leftSpaceToView(self.inspectOrgLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.inspectOrgLabel)
    .heightIs(35);
    
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.inspectOrgLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.nameTextField.sd_layout
    .leftSpaceToView(self.nameLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.nameLabel)
    .heightIs(35);

    self.phoneLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.nameLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.phoneLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.phoneLabel)
    .heightIs(35);

    self.sampleNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.phoneLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.sampleNameTextField.sd_layout
    .leftSpaceToView(self.sampleNameLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sampleNameLabel)
    .heightIs(35);

    self.sampleNumLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.sampleNumTextField.sd_layout
    .leftSpaceToView(self.sampleNumLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.sampleNumLabel)
    .heightIs(35);

    self.specLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNumLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.specTextField.sd_layout
    .leftSpaceToView(self.specLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.specLabel)
    .heightIs(35);


    self.excStandardLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.specLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.excStandardTextField.sd_layout
    .leftSpaceToView(self.excStandardLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.excStandardLabel)
    .heightIs(35);


    self.projectLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.excStandardLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.projectTextField.sd_layout
    .leftSpaceToView(self.projectLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.projectLabel)
    .heightIs(35);

    self.projectBasisLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.projectLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.projectBasisTextField.sd_layout
    .leftSpaceToView(self.projectBasisLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.projectBasisLabel)
    .heightIs(35);
    
    self.createTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.projectBasisLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.createTimeTextField.sd_layout
    .leftSpaceToView(self.createTimeLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.createTimeLabel)
    .heightIs(35);

    
    self.producerAddressLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.producerAddressTextField.sd_layout
    .leftSpaceToView(self.producerAddressLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.producerAddressLabel)
    .heightIs(35);

    

    self.takeWayLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.producerAddressLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.takeWayTextField.sd_layout
    .leftSpaceToView(self.takeWayLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.takeWayLabel)
    .heightIs(35);
    
    self.acceptUserNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.takeWayLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.acceptUserNameTextField.sd_layout
    .leftSpaceToView(self.acceptUserNameLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.acceptUserNameLabel)
    .heightIs(35);
    
    self.acceptUserPhoneLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptUserNameLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.acceptUserPhoneTextField.sd_layout
    .leftSpaceToView(self.acceptUserPhoneLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.acceptUserPhoneLabel)
    .heightIs(35);
    
    self.acceptTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptUserPhoneLabel, 5)
    .heightIs(35).widthIs(100);
    
    self.acceptTimeTextField.sd_layout
    .leftSpaceToView(self.acceptTimeLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.acceptTimeLabel)
    .heightIs(35);
}

-(void)setModel:(xw_EntrustInspectModel *)model{
    _model = model;
    self.snTextField.text = _model.sn;
    
    if([self.type isEqualToString:@"ACCEPT"]){
        self.sourceTextField.text = @"自主申请";
        self.inspectOrgTextField.text = [xw_DataParsingHelper getSingleOrgsNameById:_model.inspectOrgId];
        self.inspectOrgTextField.enabled = NO;
    } else if([self.type isEqualToString:@"DISPATCH"]){
        self.sourceTextField.text = [NSString stringWithFormat:@"%@派单",[xw_DataParsingHelper getSingleOrgsNameById:_model.inspectOrgId]];
        self.inspectOrgTextField.text = @"";
    } else {
        self.sourceTextField.text = _model.source;
    }
    self.busCategoryTextField.text = [xw_DataParsingHelper GetDictNameBySubCode:@"BUS_CATEGORY" subCode:_model.busCategory];
    
    
    self.nameTextField.text = _model.entrustOrg.name;
    self.phoneTextField.text = _model.entrustOrg.phone;
    
    self.sampleNameTextField.text = _model.sampleName;
    self.sampleNumTextField.text = _model.sampleNum;
    self.specTextField.text = _model.spec;
    self.excStandardTextField.text = _model.excStandard;
    self.projectTextField.text = _model.project;
    self.projectBasisTextField.text = _model.projectBasis;
    
    self.createTimeTextField.text = _model.createTime;
    self.producerAddressTextField.text = _model.producerAddress;
    self.takeWayTextField.text = [xw_DataParsingHelper GetDictNameBySubCode:@"TAKE_WAY" subCode:_model.takeWay];

    self.acceptUserNameTextField.text = _model.acceptUserName;
    self.acceptUserPhoneTextField.text = _model.acceptUserPhone;
    self.acceptTimeTextField.text = _model.acceptTime;
    
    
    
}
-(UILabel*)snLabel{
    if (!_snLabel) {
        _snLabel = [UILabel labelWithText:@"检测编号" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _snLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"检测编号*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _snLabel;
}

-(UITextField*)snTextField{
    if(!_snTextField){
        _snTextField = [UITextField new];
        _snTextField.font = FONT(13);
        _snTextField.textColor = COLOR(@"#171717");
        _snTextField.textAlignment = NSTextAlignmentLeft;
        _snTextField.placeholder = @"请输入检测编号";
        _snTextField.backgroundColor = COLOR(@"#F5F5F5");
        [_snTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_snTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.sn = x;
        }];
        ViewRadius(_snTextField, 5);
    }
    return _snTextField;
}
-(UILabel*)sourceLabel{
    if (!_sourceLabel) {
        _sourceLabel = [UILabel labelWithText:@"委托来源" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _sourceLabel;
}

-(UITextField*)sourceTextField{
    if(!_sourceTextField){
        _sourceTextField = [UITextField new];
        _sourceTextField.font = FONT(13);
        _sourceTextField.textColor = COLOR(@"#171717");
        _sourceTextField.textAlignment = NSTextAlignmentLeft;
        _sourceTextField.placeholder = @"";
        _sourceTextField.enabled = NO;
        [_sourceTextField setTextFieldLeftPadding:10];
        ViewRadius(_sourceTextField, 5);
    }
    return _sourceTextField;
}
-(UILabel*)busCategoryLabel{
    if (!_busCategoryLabel) {
        _busCategoryLabel = [UILabel labelWithText:@"业务类别" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
        _busCategoryLabel.attributedText = [NSAttributedString getAttributeWith:@"*"  string:@"业务类别*" orginFont:FONT(15) orginColor:COLOR(@"#171717") attributeFont:FONT(15) attributeColor:COLOR(@"#FF0000") textAlignment:NSTextAlignmentLeft];
    }
    return _busCategoryLabel;
}

-(UITextField*)busCategoryTextField{
    if(!_busCategoryTextField){
        _busCategoryTextField = [UITextField new];
        _busCategoryTextField.font = FONT(13);
        _busCategoryTextField.textColor = COLOR(@"#171717");
        _busCategoryTextField.textAlignment = NSTextAlignmentLeft;
        _busCategoryTextField.placeholder = @"请输入业务类别";
        _busCategoryTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_busCategoryTextField, 5);
        @weakify(self);
        [_busCategoryTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.busCategory = x;
        }];
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);

        _busCategoryTextField.rightView = rightView;
        _busCategoryTextField.rightViewMode = UITextFieldViewModeAlways;
        _busCategoryTextField.delegate = self;
        [_busCategoryTextField setTextFieldLeftPadding:10];
    }
    return _busCategoryTextField;
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
        _nameTextField.placeholder = @"";
        _nameTextField.enabled = NO;
        [_nameTextField setTextFieldLeftPadding:10];
        ViewRadius(_nameTextField, 5);
    }
    return _nameTextField;
}

-(UILabel*)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel labelWithText:@"联系人电话" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _phoneLabel;
}

-(UITextField*)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [UITextField new];
        _phoneTextField.font = FONT(13);
        _phoneTextField.textColor = COLOR(@"#171717");
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        _phoneTextField.placeholder = @"";
        _phoneTextField.enabled = NO;
        [_phoneTextField setTextFieldLeftPadding:10];
        ViewRadius(_phoneTextField, 5);
    }
    return _phoneTextField;
}
-(UILabel*)sampleNameLabel{
    if (!_sampleNameLabel) {
        _sampleNameLabel = [UILabel labelWithText:@"样品名称" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _sampleNameLabel;
}

-(UITextField*)sampleNameTextField{
    if(!_sampleNameTextField){
        _sampleNameTextField = [UITextField new];
        _sampleNameTextField.font = FONT(13);
        _sampleNameTextField.textColor = COLOR(@"#171717");
        _sampleNameTextField.textAlignment = NSTextAlignmentLeft;
        _sampleNameTextField.enabled = NO;
        ViewRadius(_sampleNameTextField, 5);
        
        [_sampleNameTextField setTextFieldLeftPadding:10];
    }
    return _sampleNameTextField;
}

-(UILabel*)sampleNumLabel{
    if (!_sampleNumLabel) {
        _sampleNumLabel = [UILabel labelWithText:@"样品份数" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _sampleNumLabel;
}

-(UITextField*)sampleNumTextField{
    if(!_sampleNumTextField){
        _sampleNumTextField = [UITextField new];
        _sampleNumTextField.font = FONT(13);
        _sampleNumTextField.textColor = COLOR(@"#171717");
        _sampleNumTextField.textAlignment = NSTextAlignmentLeft;
        _sampleNumTextField.placeholder = @"";
        _sampleNumTextField.enabled = NO;
        ViewRadius(_sampleNumTextField, 5);
        
        [_sampleNumTextField setTextFieldLeftPadding:10];
    }
    return _sampleNumTextField;
}

-(UILabel*)specLabel{
    if (!_specLabel) {
        _specLabel = [UILabel labelWithText:@"规格型号" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _specLabel;
}

-(UITextField*)specTextField{
    if(!_specTextField){
        _specTextField = [UITextField new];
        _specTextField.font = FONT(13);
        _specTextField.textColor = COLOR(@"#171717");
        _specTextField.textAlignment = NSTextAlignmentLeft;
        _specTextField.placeholder = @"";
        _specTextField.enabled = NO;
        ViewRadius(_specTextField, 5);
        
        [_specTextField setTextFieldLeftPadding:10];
    }
    return _specTextField;
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

-(UILabel*)createTimeLabel{
    if (!_createTimeLabel) {
        _createTimeLabel = [UILabel labelWithText:@"申请时间" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _createTimeLabel;
}

-(UITextField*)createTimeTextField{
    if(!_createTimeTextField){
        _createTimeTextField = [UITextField new];
        _createTimeTextField.font = FONT(13);
        _createTimeTextField.textColor = COLOR(@"#171717");
        _createTimeTextField.textAlignment = NSTextAlignmentLeft;
        _createTimeTextField.enabled = NO;
        ViewRadius(_createTimeTextField, 5);
        
        [_createTimeTextField setTextFieldLeftPadding:10];
    }
    return _createTimeTextField;
}

-(UILabel*)producerAddressLabel{
    if (!_producerAddressLabel) {
        _producerAddressLabel = [UILabel labelWithText:@"地址" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _producerAddressLabel;
}

-(UITextField*)producerAddressTextField{
    if(!_producerAddressTextField){
        _producerAddressTextField = [UITextField new];
        _producerAddressTextField.font = FONT(13);
        _producerAddressTextField.textColor = COLOR(@"#171717");
        _producerAddressTextField.textAlignment = NSTextAlignmentLeft;
        _producerAddressTextField.enabled = NO;
        ViewRadius(_producerAddressTextField, 5);
        
        [_producerAddressTextField setTextFieldLeftPadding:10];
    }
    return _producerAddressTextField;
}





-(UILabel*)takeWayLabel{
    if (!_takeWayLabel) {
        _takeWayLabel = [UILabel labelWithText:@"报告拿取方式" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _takeWayLabel;
}
-(UITextField*)takeWayTextField{
    if(!_takeWayTextField){
        _takeWayTextField = [UITextField new];
        _takeWayTextField.font = FONT(13);
        _takeWayTextField.textColor = COLOR(@"#171717");
        _takeWayTextField.textAlignment = NSTextAlignmentLeft;
        _takeWayTextField.enabled = NO;
        ViewRadius(_takeWayTextField, 5);
        [_takeWayTextField setTextFieldLeftPadding:10];
    }
    return _takeWayTextField;
}
-(UILabel*)acceptUserNameLabel{
    if (!_acceptUserNameLabel) {
        _acceptUserNameLabel = [UILabel labelWithText:@"受理人员" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _acceptUserNameLabel;
}
-(UITextField*)acceptUserNameTextField{
    if(!_acceptUserNameTextField){
        _acceptUserNameTextField = [UITextField new];
        _acceptUserNameTextField.font = FONT(13);
        _acceptUserNameTextField.textColor = COLOR(@"#171717");
        _acceptUserNameTextField.textAlignment = NSTextAlignmentLeft;
        _acceptUserNameTextField.enabled = NO;
        ViewRadius(_acceptUserNameTextField, 5);
        [_acceptUserNameTextField setTextFieldLeftPadding:10];
    }
    return _acceptUserNameTextField;
}
-(UILabel*)acceptUserPhoneLabel{
    if (!_acceptUserPhoneLabel) {
        _acceptUserPhoneLabel = [UILabel labelWithText:@"受理人电话" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _acceptUserPhoneLabel;
}
-(UITextField*)acceptUserPhoneTextField{
    if(!_acceptUserPhoneTextField){
        _acceptUserPhoneTextField = [UITextField new];
        _acceptUserPhoneTextField.font = FONT(13);
        _acceptUserPhoneTextField.textColor = COLOR(@"#171717");
        _acceptUserPhoneTextField.textAlignment = NSTextAlignmentLeft;
        _acceptUserPhoneTextField.enabled = NO;
        ViewRadius(_acceptUserPhoneTextField, 5);
        [_acceptUserPhoneTextField setTextFieldLeftPadding:10];
    }
    return _acceptUserPhoneTextField;
}
-(UILabel*)acceptTimeLabel{
    if (!_acceptTimeLabel) {
        _acceptTimeLabel = [UILabel labelWithText:@"受理时间" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _acceptTimeLabel;
}
-(UITextField*)acceptTimeTextField{
    if(!_acceptTimeTextField){
        _acceptTimeTextField = [UITextField new];
        _acceptTimeTextField.font = FONT(13);
        _acceptTimeTextField.textColor = COLOR(@"#171717");
        _acceptTimeTextField.textAlignment = NSTextAlignmentLeft;
        _acceptTimeTextField.enabled = NO;
        ViewRadius(_acceptTimeTextField, 5);
        [_acceptTimeTextField setTextFieldLeftPadding:10];
    }
    return _acceptTimeTextField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.busCategoryTextField ){
        [self showCategory];
    }
    else if(textField == self.inspectOrgTextField){
        [self showPick];
    }
    return NO;
}


-(void)showCategory{
    NSArray* array = [xw_DataParsingHelper getDictPickList:@"BUS_CATEGORY"];
    Dialog()
   .wTypeSet(DialogTypePickSelect)
   .wListDefaultValueSet(array[0][@"name"])  //默认
   .wEventOKFinishSet(^(id anyID, id otherData) {
          NSLog(@"%@",anyID[@"item"]);
       ChildrenModel* model = anyID[@"item"];
       self.busCategoryTextField.text = model.name;
       self.model.busCategory = model.id;
    })
   //一层直接传入带字典/字符串的数组 name为显示的文字 其他携带的model可以自由传入
   .wDataSet(array)
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
