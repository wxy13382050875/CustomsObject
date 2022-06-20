//
//  xw_AccetpCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/13.
//

#import "xw_AccetpCell.h"

@interface xw_AccetpCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UITextField* snTextField;

@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UITextField* sampleNameTextField;

@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UITextField* inspectOrgTextField;

@property(nonatomic,strong)UILabel* entrustOrgLabel;
@property(nonatomic,strong)UITextField* entrustOrgTextField;

@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UITextField* createTimeTextField;

@property(nonatomic,strong)UILabel* acceptUserNameLabel;
@property(nonatomic,strong)UITextField* acceptUserNameTextField;

@property(nonatomic,strong)UILabel* acceptTimeLabel;
@property(nonatomic,strong)UITextField* acceptTimeTextField;
@end
@implementation xw_AccetpCell

-(void)xw_setupUI{
    [self.contentView addSubview:self.snLabel];
    [self.contentView addSubview:self.snTextField];
    
    [self.contentView addSubview:self.sampleNameLabel];
    [self.contentView addSubview:self.sampleNameTextField];

    [self.contentView addSubview:self.inspectOrgLabel];
    [self.contentView addSubview:self.inspectOrgTextField];

    [self.contentView addSubview:self.entrustOrgLabel];
    [self.contentView addSubview:self.entrustOrgTextField];

    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.createTimeTextField];

    [self.contentView addSubview:self.acceptUserNameLabel];
    [self.contentView addSubview:self.acceptUserNameTextField];

    [self.contentView addSubview:self.acceptTimeLabel];
    [self.contentView addSubview:self.acceptTimeTextField];
}
-(void)xw_updateConstraints{
    
    self.snLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.snTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.snLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.sampleNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.snTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.sampleNameTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);

    self.inspectOrgLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.inspectOrgTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.inspectOrgLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);

    self.entrustOrgLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.inspectOrgTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.entrustOrgTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.entrustOrgLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);

    self.createTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.entrustOrgTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.createTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.acceptUserNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.acceptUserNameTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptUserNameLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);

    self.acceptTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptUserNameTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    
    self.acceptTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptTimeLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
}

-(void)setModel:(xw_HandleQueryModel *)model{
    _model = model;

    @weakify(self);
    self.snTextField.text = _model.sn;
    
    [self.snTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.sn = x;
    }];
    
    self.sampleNameTextField.text = _model.sampleName;
    [self.sampleNameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.sampleName = x;
    }];
    
    self.entrustOrgTextField.text = _model.entrustOrgName;
    [self.entrustOrgTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.entrustOrgName = x;
    }];
    
    self.acceptUserNameTextField.text = _model.acceptUserName;
    [self.acceptUserNameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.acceptUserName = x;
    }];
    
    self.inspectOrgTextField.text = _model.inspectOrgName;
    [self.inspectOrgTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.inspectOrgName = x;
    }];
    
    self.createTimeTextField.text = _model.createTime;
    [self.createTimeTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.createTime = x;
    }];
    
    self.acceptTimeTextField.text = _model.acceptTime;
    [self.acceptTimeTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.acceptTime = x;
    }];
}

-(UILabel*)snLabel{
    if (!_snLabel) {
        _snLabel = [UILabel labelWithText:@"检测编号" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
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
        ViewRadius(_snTextField, 5);
        [_snTextField setTextFieldLeftPadding:10];
    }
    return _snTextField;
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
        _sampleNameTextField.placeholder = @"请输入样品名称";
        _sampleNameTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_sampleNameTextField, 5);
        [_sampleNameTextField setTextFieldLeftPadding:10];
    }
    return _sampleNameTextField;
}
-(UILabel*)inspectOrgLabel{
    if (!_inspectOrgLabel) {
        _inspectOrgLabel = [UILabel labelWithText:@"检疫机构" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _inspectOrgLabel;
}

-(UITextField*)inspectOrgTextField{
    if(!_inspectOrgTextField){
        _inspectOrgTextField = [UITextField new];
        _inspectOrgTextField.font = FONT(13);
        _inspectOrgTextField.textColor = COLOR(@"#171717");
        _inspectOrgTextField.textAlignment = NSTextAlignmentLeft;
        _inspectOrgTextField.placeholder = @"请选择检疫机构";
        _inspectOrgTextField.backgroundColor = COLOR(@"#F5F5F5");
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);
        
        _inspectOrgTextField.rightView = rightView;
        _inspectOrgTextField.rightViewMode = UITextFieldViewModeAlways;
        _inspectOrgTextField.delegate = self;
        
        ViewRadius(_inspectOrgTextField, 5);
        [_inspectOrgTextField setTextFieldLeftPadding:10];
    }
    return _inspectOrgTextField;
}
-(UILabel*)entrustOrgLabel{
    if (!_entrustOrgLabel) {
        _entrustOrgLabel = [UILabel labelWithText:@"申请企业" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _entrustOrgLabel;
}

-(UITextField*)entrustOrgTextField{
    if(!_entrustOrgTextField){
        _entrustOrgTextField = [UITextField new];
        _entrustOrgTextField.font = FONT(13);
        _entrustOrgTextField.textColor = COLOR(@"#171717");
        _entrustOrgTextField.textAlignment = NSTextAlignmentLeft;
        _entrustOrgTextField.placeholder = @"请输入申请企业";
        _entrustOrgTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_entrustOrgTextField, 5);
        [_entrustOrgTextField setTextFieldLeftPadding:10];
    }
    return _entrustOrgTextField;
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
        _createTimeTextField.placeholder = @"请选择申请时间";
        _createTimeTextField.backgroundColor = COLOR(@"#F5F5F5");
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);
        
        _createTimeTextField.rightView = rightView;
        _createTimeTextField.rightViewMode = UITextFieldViewModeAlways;
        
        _createTimeTextField.delegate = self;
        ViewRadius(_createTimeTextField, 5);
        [_createTimeTextField setTextFieldLeftPadding:10];
    }
    return _createTimeTextField;
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
        _acceptUserNameTextField.placeholder = @"请输入受理人员";
        _acceptUserNameTextField.backgroundColor = COLOR(@"#F5F5F5");
        ViewRadius(_acceptUserNameTextField, 5);
        [_acceptUserNameTextField setTextFieldLeftPadding:10];
    }
    return _acceptUserNameTextField;
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
        _acceptTimeTextField.placeholder = @"请选择受理时间";
        _acceptTimeTextField.backgroundColor = COLOR(@"#F5F5F5");
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);
        
        _acceptTimeTextField.rightView = rightView;
        _acceptTimeTextField.rightViewMode = UITextFieldViewModeAlways;
        ViewRadius(_acceptTimeTextField, 5);
        _acceptTimeTextField.delegate = self;
        [_acceptTimeTextField setTextFieldLeftPadding:10];
    }
    return _acceptTimeTextField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.createTimeTextField ||
       textField == self.acceptTimeTextField ){
        [self showCalander:textField];
    } else if(textField == self.inspectOrgTextField){
        [self showPick];
    }
    return NO;
}

-(void)showCalander:(UITextField *)textField{
    Dialog()
    /// 隐藏农历
    .wOpenChineseDateSet(NO)
    /// 显示在底部
    .wMainToBottomSet(YES)
    .wTypeSet(DialogTypeCalander)
    .wEventOKFinishSet(^(id anyID, NSArray* otherData) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        WMZCalanderModel* from = [otherData firstObject];
        WMZCalanderModel* to = [otherData lastObject];
        if (textField == self.acceptTimeTextField) {
            self.acceptTimeTextField.text = anyID;
            self.model.acceptTimeFrom = [formatter stringFromDate:from.wDate];
            self.model.acceptTimeTo = [formatter stringFromDate:to.wDate];
        }
        if (textField == self.createTimeTextField) {
            self.createTimeTextField.text = anyID;
            self.model.from = [formatter stringFromDate:from.wDate];
            self.model.to = [formatter stringFromDate:to.wDate];
        }
    })
    /// 多选
    .wMultipleSelectionSet(YES)
    /// 关闭多选多块区域 有连续性
    .wOpenMultiZoneSet(NO)
    /// 主题色
    .wOKColorSet(DialogColor(0x0096ff))
    /// 默认选中
    .wListDefaultValueSet(@[
        [NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],
        [NSDate date],
        [NSDate dateWithTimeIntervalSinceNow:24*60*60],
        [NSDate dateWithTimeIntervalSinceNow:3*24*60*60],
        ])
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
