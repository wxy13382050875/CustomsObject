//
//  xw_SampleCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/13.
//

#import "xw_SampleCell.h"

@interface xw_SampleCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel* entrustOrgLabel;
@property(nonatomic,strong)UITextField* entrustOrgTextField;

@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UITextField* sampleNameTextField;

@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UITextField* createTimeTextField;


@property(nonatomic,strong)UILabel* acceptTimeLabel;
@property(nonatomic,strong)UITextField* acceptTimeTextField;

@property(nonatomic,strong)UILabel* samplingTimeLabel;
@property(nonatomic,strong)UITextField* samplingTimeTextField;
@end
@implementation xw_SampleCell

-(void)xw_setupUI{
    [self.contentView addSubview:self.entrustOrgLabel];
    [self.contentView addSubview:self.entrustOrgTextField];
    
    [self.contentView addSubview:self.sampleNameLabel];
    [self.contentView addSubview:self.sampleNameTextField];

    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.createTimeTextField];

    [self.contentView addSubview:self.acceptTimeLabel];
    [self.contentView addSubview:self.acceptTimeTextField];
    
    [self.contentView addSubview:self.samplingTimeLabel];
    [self.contentView addSubview:self.samplingTimeTextField];
}
-(void)xw_updateConstraints{
    
    self.entrustOrgLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.entrustOrgTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.entrustOrgLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.sampleNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.entrustOrgTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.sampleNameTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);


    self.createTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.createTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    

    self.acceptTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    
    self.acceptTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptTimeLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.samplingTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.acceptTimeTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    
    self.samplingTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.samplingTimeLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
}

-(void)setModel:(xw_HandleQueryModel *)model{
    _model = model;

    @weakify(self);

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
    
    self.samplingTimeTextField.text = _model.samplingTime;
    [self.samplingTimeTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.samplingTime = x;
    }];
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

-(UILabel*)entrustOrgLabel{
    if (!_entrustOrgLabel) {
        _entrustOrgLabel = [UILabel labelWithText:@"委托单位" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _entrustOrgLabel;
}

-(UITextField*)entrustOrgTextField{
    if(!_entrustOrgTextField){
        _entrustOrgTextField = [UITextField new];
        _entrustOrgTextField.font = FONT(13);
        _entrustOrgTextField.textColor = COLOR(@"#171717");
        _entrustOrgTextField.textAlignment = NSTextAlignmentLeft;
        _entrustOrgTextField.placeholder = @"请输入委托单位";
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
-(UILabel*)samplingTimeLabel{
    if (!_samplingTimeLabel) {
        _samplingTimeLabel = [UILabel labelWithText:@"采样时间" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _samplingTimeLabel;
}

-(UITextField*)samplingTimeTextField{
    if(!_samplingTimeTextField){
        _samplingTimeTextField = [UITextField new];
        _samplingTimeTextField.font = FONT(13);
        _samplingTimeTextField.textColor = COLOR(@"#171717");
        _samplingTimeTextField.textAlignment = NSTextAlignmentLeft;
        _samplingTimeTextField.placeholder = @"请选择采样时间";
        _samplingTimeTextField.backgroundColor = COLOR(@"#F5F5F5");
        UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_down_arrow");
        [rightView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(rightView)
        .centerYEqualToView(rightView).widthIs(12).heightIs(6);
        
        _samplingTimeTextField.rightView = rightView;
        _samplingTimeTextField.rightViewMode = UITextFieldViewModeAlways;
        ViewRadius(_samplingTimeTextField, 5);
        _samplingTimeTextField.delegate = self;
        [_samplingTimeTextField setTextFieldLeftPadding:10];
    }
    return _samplingTimeTextField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.createTimeTextField ||
       textField == self.acceptTimeTextField ||
       textField == self.samplingTimeTextField ){
        [self showCalander:textField];
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
        if (textField == self.samplingTimeTextField) {
            self.samplingTimeTextField.text = anyID;
            self.model.samplingTimeFrom = [formatter stringFromDate:from.wDate];
            self.model.samplingTimeTo = [formatter stringFromDate:to.wDate];
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


@end
