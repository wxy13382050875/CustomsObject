//
//  xw_DelegateHandleCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_DelegateHandleCell.h"

@interface xw_DelegateHandleCell ()
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UITextField* snTextField;
@property(nonatomic,strong)UITextField* sourceTextField;
@property(nonatomic,strong)UITextField* busCategoryTextField;
@property(nonatomic,strong)UITextField* inspectOrgTextField;
@property(nonatomic,strong)UITextField* entrustOrgTextField;

@property(nonatomic,strong)UIButton* foldIBtn;

@property(nonatomic,strong)UILabel* line;

@property(nonatomic,strong)UIView* foldView;
@property(nonatomic,strong)UITextField* phoneTextField;
@property(nonatomic,strong)UITextField* sampleNameTextField;
@property(nonatomic,strong)UITextField* sampleNumTextField;
@property(nonatomic,strong)UITextField* specTextField;
@property(nonatomic,strong)UITextField* excStandardTextField;
@property(nonatomic,strong)UITextField* projectTextField;
@property(nonatomic,strong)UITextField* projectBasisTextField;
@property(nonatomic,strong)UITextField* createTimeTextField;
@property(nonatomic,strong)UITextField* producerAddressTextField;
@property(nonatomic,strong)UITextField* takeWayTextField;

@property(nonatomic,strong)UIView* acceptView;
@property(nonatomic,strong)UITextField* acceptUserNameTextField;
@property(nonatomic,strong)UITextField* acceptUserPhoneTextField;
@property(nonatomic,strong)UITextField* acceptTimeTextField;

@property(nonatomic,strong)UIView* resultView;
@property(nonatomic,strong)UITextField* inspectResultTextField;
@property(nonatomic,strong)UITextField* expressNoTextField;
@property(nonatomic,strong)UIButton* logisticsBthBth;

@property(nonatomic,strong)UITextField* registerUserNameTextField;
@property(nonatomic,strong)UITextField* registerTimeTextField;

@property(nonatomic,strong)UILabel* line1;
@end
@implementation xw_DelegateHandleCell
-(void)xw_setupUI{
    self.xw_height = 150;
    [self.contentView addSubview:self.snLabel];
    [self.contentView addSubview:self.snTextField];
    [self.contentView addSubview:self.sourceTextField];
    [self.contentView addSubview:self.busCategoryTextField];
    [self.contentView addSubview:self.inspectOrgTextField];
    [self.contentView addSubview:self.entrustOrgTextField];
    [self.contentView addSubview:self.foldIBtn];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.foldView];
    [self.foldView addSubview:self.phoneTextField];
    [self.foldView addSubview:self.sampleNameTextField];
    [self.foldView addSubview:self.sampleNumTextField];
    [self.foldView addSubview:self.specTextField];
    [self.foldView addSubview:self.excStandardTextField];
    [self.foldView addSubview:self.projectTextField];
    [self.foldView addSubview:self.projectBasisTextField];
    [self.foldView addSubview:self.createTimeTextField];
    [self.foldView addSubview:self.producerAddressTextField];
    [self.foldView addSubview:self.takeWayTextField];
    
    [self.foldView addSubview:self.acceptView];
    [self.acceptView addSubview:self.acceptUserNameTextField];
    [self.acceptView addSubview:self.acceptUserPhoneTextField];
    [self.acceptView addSubview:self.acceptTimeTextField];
    
    [self.foldView addSubview:self.resultView];
    [self.resultView addSubview:self.inspectResultTextField];
    [self.resultView addSubview:self.expressNoTextField];
    [self.resultView addSubview:self.logisticsBthBth];
    [self.resultView addSubview:self.registerUserNameTextField];
    [self.resultView addSubview:self.registerTimeTextField];
}
-(void)xw_updateConstraints{
    self.snLabel.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .heightIs(30).widthIs(60);
    
    self.snTextField.sd_layout
    .leftSpaceToView(self.snLabel, 0)
    .rightSpaceToView(self.contentView, 80)
    .topSpaceToView(self.contentView, 5)
    .heightIs(30);
    
    self.sourceTextField.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.snLabel, 0)
    .heightIs(30);
    
    self.busCategoryTextField.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.sourceTextField, 0)
    .heightIs(30);
    
    self.inspectOrgTextField.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.busCategoryTextField, 0)
    .heightIs(30);
    
    self.entrustOrgTextField.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.inspectOrgTextField, 0)
    .heightIs(30);
    
    self.line.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.entrustOrgTextField, 0)
    .heightIs(1);
    
    
    self.foldIBtn.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 60)
    .heightIs(30).widthIs(30);
    
    self.foldView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .topSpaceToView(self.line, 0);
    
    self.phoneTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topEqualToView(self.foldView)
    .heightIs(30);
    
    self.sampleNameTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.phoneTextField, 0)
    .heightIs(30);
    
    self.sampleNumTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.sampleNameTextField, 0)
    .heightIs(30);
    
    self.specTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.sampleNumTextField, 0)
    .heightIs(30);
    
    self.excStandardTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.specTextField, 0)
    .heightIs(30);
    
    self.projectTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.excStandardTextField, 0)
    .heightIs(30);
    
    self.projectBasisTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.projectTextField, 0)
    .heightIs(30);
    
    self.createTimeTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.projectBasisTextField, 0)
    .heightIs(30);
    
    self.producerAddressTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.createTimeTextField, 0)
    .heightIs(30);
    
    self.takeWayTextField.sd_layout
    .leftSpaceToView(self.foldView, 10)
    .rightSpaceToView(self.foldView, 10)
    .topSpaceToView(self.producerAddressTextField, 0)
    .heightIs(30);
    
    self.acceptView.sd_layout
    .leftEqualToView(self.foldView)
    .rightEqualToView(self.foldView)
    .topSpaceToView(self.takeWayTextField, 0)
    .heightIs(90);
    
    self.acceptUserNameTextField.sd_layout
    .leftSpaceToView(self.acceptView, 10)
    .rightSpaceToView(self.acceptView, 10)
    .topEqualToView(self.acceptView)
    .heightIs(30);
    
    self.acceptUserPhoneTextField.sd_layout
    .leftSpaceToView(self.acceptView, 10)
    .rightSpaceToView(self.acceptView, 10)
    .topSpaceToView(self.acceptUserNameTextField, 0)
    .heightIs(30);
    
    self.acceptTimeTextField.sd_layout
    .leftSpaceToView(self.acceptView, 10)
    .rightSpaceToView(self.acceptView, 10)
    .topSpaceToView(self.acceptUserPhoneTextField, 0)
    .heightIs(30);
    
    self.resultView.sd_layout
    .leftEqualToView(self.foldView)
    .rightEqualToView(self.foldView)
    .topSpaceToView(self.acceptView, 0)
    .heightIs(120);

    self.inspectResultTextField.sd_layout
    .leftSpaceToView(self.resultView, 10)
    .rightSpaceToView(self.resultView, 10)
    .topEqualToView(self.resultView)
    .heightIs(30);
    
    self.expressNoTextField.sd_layout
    .leftSpaceToView(self.resultView, 10)
    .rightSpaceToView(self.resultView, 10)
    .topSpaceToView(self.inspectResultTextField, 0)
    .heightIs(30);
    
    self.logisticsBthBth.sd_layout
    .rightSpaceToView(self.resultView, 10)
    .topSpaceToView(self.inspectResultTextField, 0)
    .heightIs(30).widthIs(120);
    
    self.registerUserNameTextField.sd_layout
    .leftSpaceToView(self.resultView, 10)
    .rightSpaceToView(self.resultView, 10)
    .topSpaceToView(self.expressNoTextField, 0)
    .heightIs(30);
    
    self.registerTimeTextField.sd_layout
    .leftSpaceToView(self.resultView, 10)
    .rightSpaceToView(self.resultView, 10)
    .topSpaceToView(self.registerUserNameTextField, 0)
    .heightIs(30);
}
-(void)setModel:(xw_EntrustInspectModel *)model{
    _model = model;
    
    self.snTextField.text = model.sn;
    self.sourceTextField.text = model.source;
    self.busCategoryTextField.text = [xw_DataParsingHelper GetDictNameBySubCode:@"BUS_CATEGORY" subCode:model.busCategory];
    self.inspectOrgTextField.text = [xw_DataParsingHelper getSingleOrgsNameById: model.inspectOrgId];
    self.entrustOrgTextField.text =  model.entrustOrg.name;
    self.resultView.hidden = YES;
    self.acceptView.hidden = YES;
    self.foldIBtn.selected = model.isFold;
    if([model.queryStatus isEqualToString:@"ACCEPTED"]){
        self.snTextField.rightViewMode = UITextFieldViewModeAlways;
        self.snTextField.enabled = YES;
        self.snTextField.backgroundColor = COLOR(@"#F5F5F5");
    } else {
        self.snTextField.rightViewMode = UITextFieldViewModeNever;
        self.snTextField.enabled = NO;
        self.snTextField.backgroundColor = COLOR(@"#FFFFFF");
    }
    if(model.isFold){
        self.foldView.hidden = NO;
        self.phoneTextField.text = model.entrustOrg.phone;
        self.sampleNameTextField.text = model.sampleName;
        self.sampleNumTextField.text = model.sampleNum;
        self.specTextField.text = model.spec;
        self.excStandardTextField.text = model.excStandard;
        self.projectTextField.text = model.project;
        self.projectBasisTextField.text = model.projectBasis;
        self.createTimeTextField.text = model.createTime;
        self.producerAddressTextField.text = model.producerAddress;
        self.takeWayTextField.text = [xw_DataParsingHelper GetDictNameBySubCode:@"TAKE_WAY" subCode:model.takeWay];
//        WAIT_ACCEPT ACCEPTED WAIT_SAMPLE SAMPLED WAIT_REGISTER REGISTERED
        if (![model.queryStatus isEqualToString:@"WAIT_ACCEPT"]) {
            self.acceptView.hidden = NO;
            self.acceptUserNameTextField.text = model.acceptUserName;
            self.acceptUserPhoneTextField.text = model.acceptUserPhone;
            self.acceptTimeTextField.text = model.acceptTime;
            if([model.queryStatus isEqualToString:@"REGISTERED"]){
                self.xw_height = 660;
                self.resultView.hidden = NO;
                self.inspectResultTextField.text = [xw_DataParsingHelper GetDictNameBySubCode:@"INSPECT_RESULT" subCode:model.inspectResult];
                self.expressNoTextField.text = model.expressNo;
                self.registerUserNameTextField.text = model.registerUserName;
                self.registerTimeTextField.text = model.registerTime;
                if(model.expressNo != nil && ![model.expressNo isEqualToString:@""]){
                    self.logisticsBthBth.hidden = NO;
                } else {
                    self.logisticsBthBth.hidden = YES;
                }
            } else {
                self.xw_height = 540;
                self.resultView.hidden = YES;
            }
        } else {
            self.xw_height = 450;
            self.acceptView.hidden = YES;
        }
        
        
        
    } else {
        self.xw_height = 150;
        self.foldView.hidden = YES;
    }
    
    
}
-(UILabel*)snLabel{
    if (!_snLabel) {
        _snLabel = [UILabel labelWithText:@"检测编号:" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:13];
    }
    return _snLabel;
}
-(UITextField*)snTextField{
    if(!_snTextField){
        _snTextField = [UITextField new];
        _snTextField.font = FONT(13);
        _snTextField.textColor = COLOR(@"#2C2C2B");
        _snTextField.textAlignment = NSTextAlignmentLeft;
//        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
//        titleLabel.text = @"检测编号:";
//        titleLabel.textColor = COLOR(@"#2C2C2B");
//        titleLabel.font = FONT(13);
//        titleLabel.backgroundColor = COLOR(@"#ffffff");
//        _snTextField.leftView = titleLabel;
//        _snTextField.leftViewMode = UITextFieldViewModeAlways;
        _snTextField.enabled = NO;
        
        UIButton* editBth= [UIButton buttonWithTitie:@"修改" WithtextColor:COLOR(@"#206EEA") WithBackColor:COLOR(@"#D8E7FF") WithBackImage:nil WithImage:nil WithFont:12 EventBlock:^(id  _Nonnull params) {
            NSLog(@"修改");
            if (self.refreshBlock) {
                self.refreshBlock(self.model,@"edit");
            }
        }];
        ViewRadius(editBth, 5);
        editBth.frame = CGRectMake(0, 0, 80, 35);
        _snTextField.rightView = editBth;
        _snTextField.rightViewMode = UITextFieldViewModeNever;
        ViewRadius(_snTextField, 5);
        @weakify(self);
        [_snTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.sn = x;
        }];
    }
    return _snTextField;
}
-(UITextField*)sourceTextField{
    if(!_sourceTextField){
        _sourceTextField = [UITextField new];
        _sourceTextField.font = FONT(13);
        _sourceTextField.textColor = COLOR(@"#2C2C2B");
        _sourceTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"委托来源:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _sourceTextField.leftView = titleLabel;
        _sourceTextField.leftViewMode = UITextFieldViewModeAlways;
        _sourceTextField.enabled = NO;
        
        
    }
    return _sourceTextField;
}
-(UITextField*)busCategoryTextField{
    if(!_busCategoryTextField){
        _busCategoryTextField = [UITextField new];
        _busCategoryTextField.font = FONT(13);
        _busCategoryTextField.textColor = COLOR(@"#2C2C2B");
        _busCategoryTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"业务类别:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _busCategoryTextField.leftView = titleLabel;
        _busCategoryTextField.leftViewMode = UITextFieldViewModeAlways;
        _busCategoryTextField.enabled = NO;
    }
    return _busCategoryTextField;
}

-(UITextField*)inspectOrgTextField{
    if(!_inspectOrgTextField){
        _inspectOrgTextField = [UITextField new];
        _inspectOrgTextField.font = FONT(13);
        _inspectOrgTextField.textColor = COLOR(@"#2C2C2B");
        _inspectOrgTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"检测机构:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _inspectOrgTextField.leftView = titleLabel;
        _inspectOrgTextField.leftViewMode = UITextFieldViewModeAlways;
        _inspectOrgTextField.enabled = NO;
    }
    return _inspectOrgTextField;
}
-(UITextField*)entrustOrgTextField{
    if(!_entrustOrgTextField){
        _entrustOrgTextField = [UITextField new];
        _entrustOrgTextField.font = FONT(13);
        _entrustOrgTextField.textColor = COLOR(@"#2C2C2B");
        _entrustOrgTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"委托单位:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _entrustOrgTextField.leftView = titleLabel;
        _entrustOrgTextField.leftViewMode = UITextFieldViewModeAlways;
        _entrustOrgTextField.enabled = NO;
    }
    return _entrustOrgTextField;
}
-(UILabel*)line{
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = COLOR(@"#eeeeee");
    }
    return _line;
}
-(UIButton*)foldIBtn{
    if(!_foldIBtn){
        _foldIBtn = [UIButton new];
        [_foldIBtn setImage:IMG(@"icon_folding_down") forState:UIControlStateNormal] ;
        [_foldIBtn setImage:IMG(@"icon_folding_up") forState:UIControlStateSelected] ;
//        [[[_foldIBtn rac_signalForControlEvents:UIControlEventEditingDidEnd] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIButton * _Nullable x) {
//            NSLog(@"按钮被点击%@",x);
//
////            self.foldIBtn.selected = self.model.isFold;
//        }];
        [[_foldIBtn
              rac_signalForControlEvents:UIControlEventTouchUpInside]
             subscribeNext:^(id x) {
                 NSLog(@"button clicked");
            self.model.isFold = !self.model.isFold;
            if (self.refreshBlock) {
                self.refreshBlock(self.model,@"fold");
            }
        }];

//        [[_foldIBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//            NSLog(@"展开");
//            self.model.isFold = !self.model.isFold;
//            self.foldIBtn.selected = self.model.isFold;
//        }];
    }
    return _foldIBtn;
}
-(UIView*)foldView{
    if(!_foldView){
        _foldView = [UIView new];
    }
    return _foldView;
}

-(UITextField*)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [UITextField new];
        _phoneTextField.font = FONT(13);
        _phoneTextField.textColor = COLOR(@"#2C2C2B");
        _phoneTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"联系人电话:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _phoneTextField.leftView = titleLabel;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.enabled = NO;
    }
    return _phoneTextField;
}
-(UITextField*)sampleNameTextField{
    if(!_sampleNameTextField){
        _sampleNameTextField = [UITextField new];
        _sampleNameTextField.font = FONT(13);
        _sampleNameTextField.textColor = COLOR(@"#2C2C2B");
        _sampleNameTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"样品名称:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _sampleNameTextField.leftView = titleLabel;
        _sampleNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _sampleNameTextField.enabled = NO;
    }
    return _sampleNameTextField;
}
-(UITextField*)sampleNumTextField{
    if(!_sampleNumTextField){
        _sampleNumTextField = [UITextField new];
        _sampleNumTextField.font = FONT(13);
        _sampleNumTextField.textColor = COLOR(@"#2C2C2B");
        _sampleNumTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"样品份数:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _sampleNumTextField.leftView = titleLabel;
        _sampleNumTextField.leftViewMode = UITextFieldViewModeAlways;
        _sampleNumTextField.enabled = NO;
    }
    return _sampleNumTextField;
}
-(UITextField*)specTextField{
    if(!_specTextField){
        _specTextField = [UITextField new];
        _specTextField.font = FONT(13);
        _specTextField.textColor = COLOR(@"#2C2C2B");
        _specTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"规格型号:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _specTextField.leftView = titleLabel;
        _specTextField.leftViewMode = UITextFieldViewModeAlways;
        _specTextField.enabled = NO;
    }
    return _specTextField;
}
-(UITextField*)excStandardTextField{
    if(!_excStandardTextField){
        _excStandardTextField = [UITextField new];
        _excStandardTextField.font = FONT(13);
        _excStandardTextField.textColor = COLOR(@"#2C2C2B");
        _excStandardTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"执行标准:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _excStandardTextField.leftView = titleLabel;
        _excStandardTextField.leftViewMode = UITextFieldViewModeAlways;
        _excStandardTextField.enabled = NO;
    }
    return _excStandardTextField;
}
-(UITextField*)projectTextField{
    if(!_projectTextField){
        _projectTextField = [UITextField new];
        _projectTextField.font = FONT(13);
        _projectTextField.textColor = COLOR(@"#2C2C2B");
        _projectTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"检测项目:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _projectTextField.leftView = titleLabel;
        _projectTextField.leftViewMode = UITextFieldViewModeAlways;
        _projectTextField.enabled = NO;
    }
    return _projectTextField;
}
-(UITextField*)projectBasisTextField{
    if(!_projectBasisTextField){
        _projectBasisTextField = [UITextField new];
        _projectBasisTextField.font = FONT(13);
        _projectBasisTextField.textColor = COLOR(@"#2C2C2B");
        _projectBasisTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"检测项目依据:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _projectBasisTextField.leftView = titleLabel;
        _projectBasisTextField.leftViewMode = UITextFieldViewModeAlways;
        _projectBasisTextField.enabled = NO;
    }
    return _projectBasisTextField;
}
-(UITextField*)createTimeTextField{
    if(!_createTimeTextField){
        _createTimeTextField = [UITextField new];
        _createTimeTextField.font = FONT(13);
        _createTimeTextField.textColor = COLOR(@"#2C2C2B");
        _createTimeTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"申请时间:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _createTimeTextField.leftView = titleLabel;
        _createTimeTextField.leftViewMode = UITextFieldViewModeAlways;
        _createTimeTextField.enabled = NO;
    }
    return _createTimeTextField;
}
-(UITextField*)producerAddressTextField{
    if(!_producerAddressTextField){
        _producerAddressTextField = [UITextField new];
        _producerAddressTextField.font = FONT(13);
        _producerAddressTextField.textColor = COLOR(@"#2C2C2B");
        _producerAddressTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"地址:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _producerAddressTextField.leftView = titleLabel;
        _producerAddressTextField.leftViewMode = UITextFieldViewModeAlways;
        _producerAddressTextField.enabled = NO;
    }
    return _producerAddressTextField;
}
-(UITextField*)takeWayTextField{
    if(!_takeWayTextField){
        _takeWayTextField = [UITextField new];
        _takeWayTextField.font = FONT(13);
        _takeWayTextField.textColor = COLOR(@"#2C2C2B");
        _takeWayTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"报告拿取方式:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _takeWayTextField.leftView = titleLabel;
        _takeWayTextField.leftViewMode = UITextFieldViewModeAlways;
        _takeWayTextField.enabled = NO;
    }
    return _takeWayTextField;
}
-(UIView*)acceptView{
    if(!_acceptView){
        _acceptView = [UIView new];
    }
    return _acceptView;
}
-(UITextField*)acceptUserNameTextField{
    if(!_acceptUserNameTextField){
        _acceptUserNameTextField = [UITextField new];
        _acceptUserNameTextField.font = FONT(13);
        _acceptUserNameTextField.textColor = COLOR(@"#2C2C2B");
        _acceptUserNameTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"受理人员:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _acceptUserNameTextField.leftView = titleLabel;
        _acceptUserNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _acceptUserNameTextField.enabled = NO;
    }
    return _acceptUserNameTextField;
}
-(UITextField*)acceptUserPhoneTextField{
    if(!_acceptUserPhoneTextField){
        _acceptUserPhoneTextField = [UITextField new];
        _acceptUserPhoneTextField.font = FONT(13);
        _acceptUserPhoneTextField.textColor = COLOR(@"#2C2C2B");
        _acceptUserPhoneTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"受理人员电话:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _acceptUserPhoneTextField.leftView = titleLabel;
        _acceptUserPhoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _acceptUserPhoneTextField.enabled = NO;
    }
    return _acceptUserPhoneTextField;
}

-(UITextField*)acceptTimeTextField{
    if(!_acceptTimeTextField){
        _acceptTimeTextField = [UITextField new];
        _acceptTimeTextField.font = FONT(13);
        _acceptTimeTextField.textColor = COLOR(@"#2C2C2B");
        _acceptTimeTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"受理时间:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _acceptTimeTextField.leftView = titleLabel;
        _acceptTimeTextField.leftViewMode = UITextFieldViewModeAlways;
        _acceptTimeTextField.enabled = NO;
    }
    return _acceptTimeTextField;
}
-(UIView*)resultView{
    if(!_resultView){
        _resultView = [UIView new];
    }
    return _resultView;
}
-(UITextField*)inspectResultTextField{
    if(!_inspectResultTextField){
        _inspectResultTextField = [UITextField new];
        _inspectResultTextField.font = FONT(13);
        _inspectResultTextField.textColor = COLOR(@"#2C2C2B");
        _inspectResultTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"检测结果:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _inspectResultTextField.leftView = titleLabel;
        _inspectResultTextField.leftViewMode = UITextFieldViewModeAlways;
        _inspectResultTextField.enabled = NO;
    }
    return _inspectResultTextField;
}
-(UITextField*)expressNoTextField{
    if(!_expressNoTextField){
        _expressNoTextField = [UITextField new];
        _expressNoTextField.font = FONT(13);
        _expressNoTextField.textColor = COLOR(@"#2C2C2B");
        _expressNoTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"报告物流单号:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _expressNoTextField.leftView = titleLabel;
        _expressNoTextField.leftViewMode = UITextFieldViewModeAlways;
        _expressNoTextField.enabled = NO;
        
        
    }
    return _expressNoTextField;
}
-(UIButton*)logisticsBthBth{
    if(!_logisticsBthBth){
        _logisticsBthBth= [UIButton buttonWithTitie:@"查看物流" WithtextColor:COLOR(@"#206EEA") WithBackColor:COLOR(@"#D8E7FF") WithBackImage:nil WithImage:nil WithFont:12 EventBlock:^(id  _Nonnull params) {
              
            NSLog(@"查看物流");
            if (self.refreshBlock) {
                self.refreshBlock(self.model,@"logistics");
            }
        }];
        _logisticsBthBth.hidden = YES;
        ViewRadius(_logisticsBthBth, 5);
    }
    return _logisticsBthBth;
}
-(UITextField*)registerUserNameTextField{
    if(!_registerUserNameTextField){
        _registerUserNameTextField = [UITextField new];
        _registerUserNameTextField.font = FONT(13);
        _registerUserNameTextField.textColor = COLOR(@"#2C2C2B");
        _registerUserNameTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"登记人员:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _registerUserNameTextField.leftView = titleLabel;
        _registerUserNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _registerUserNameTextField.enabled = NO;
    }
    return _registerUserNameTextField;
}
-(UITextField*)registerTimeTextField{
    if(!_registerTimeTextField){
        _registerTimeTextField = [UITextField new];
        _registerTimeTextField.font = FONT(13);
        _registerTimeTextField.textColor = COLOR(@"#2C2C2B");
        _registerTimeTextField.textAlignment = NSTextAlignmentLeft;
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        titleLabel.text = @"登记时间:";
        titleLabel.textColor = COLOR(@"#2C2C2B");
        titleLabel.font = FONT(13);
        _registerTimeTextField.leftView = titleLabel;
        _registerTimeTextField.leftViewMode = UITextFieldViewModeAlways;
        _registerTimeTextField.enabled = NO;
    }
    return _registerTimeTextField;
}
@end
