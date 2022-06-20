//
//  xw_CertCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/13.
//

#import "xw_CertCell.h"

@interface xw_CertCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UITextField* snTextField;

@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UITextField* sampleNameTextField;

@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UITextField* createTimeTextField;
@end
@implementation xw_CertCell

-(void)xw_setupUI{
    [self.contentView addSubview:self.snLabel];
    [self.contentView addSubview:self.snTextField];
    
    [self.contentView addSubview:self.sampleNameLabel];
    [self.contentView addSubview:self.sampleNameTextField];

    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.createTimeTextField];
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

    

    self.createTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleNameTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.createTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeLabel, 0)
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
    
    self.createTimeTextField.text = _model.createTime;
    [self.createTimeTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.createTime = x;
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.createTimeTextField ){
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
@end
