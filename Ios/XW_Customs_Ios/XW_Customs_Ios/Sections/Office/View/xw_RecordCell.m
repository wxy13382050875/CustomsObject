//
//  xw_RecordCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/13.
//

#import "xw_RecordCell.h"
#import "RadioButton.h"
@interface xw_RecordCell ()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UITextField* sampleNameTextField;

@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UITextField* inspectOrgTextField;
@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UITextField* createTimeTextField;

@property(nonatomic,strong)UILabel* acceptStateNameLabel;
@property(nonatomic,strong)NSMutableArray* buttons;
@end
@implementation xw_RecordCell

-(void)xw_setupUI{
    [self.contentView addSubview:self.sampleNameLabel];
    [self.contentView addSubview:self.sampleNameTextField];

    [self.contentView addSubview:self.inspectOrgLabel];
    [self.contentView addSubview:self.inspectOrgTextField];

    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.createTimeTextField];

    [self.contentView addSubview:self.acceptStateNameLabel];
//    [self.contentView addSubview:self.acceptStateNameTextField];
}
-(void)xw_updateConstraints{
    
    self.sampleNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
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

    

    self.createTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.inspectOrgTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.createTimeTextField.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeLabel, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
    self.acceptStateNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.createTimeTextField, 0)
    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);
    
//    self.acceptStateNameTextField.sd_layout
//    .leftSpaceToView(self.contentView, 20)
//    .topSpaceToView(self.acceptStateNameLabel, 0)
//    .heightIs(30).widthIs(SCREEN_WIDTH* 0.75 - 40);

    
}

-(void)setModel:(xw_HandleQueryModel *)model{
    _model = model;
    @weakify(self);
    
    
    self.sampleNameTextField.text = _model.sampleName;
    [self.sampleNameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.sampleName = x;
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
    
    [self.buttons removeAllObjects];
    NSArray* array = [xw_DataParsingHelper getDictItemByCode:@"ENTRUST_STATUS"];
    NSInteger index = 0;
    for (int i = 0; i < array.count; i ++) {
        xw_DictModel* tm = array[i];
        RadioButton* radioBtn = [RadioButton new];
//        [radioBtn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
        [radioBtn setTitle:tm.name forState:UIControlStateNormal];
        radioBtn.titleLabel.font = FONT(12);
        [radioBtn setTitleColor:COLOR(@"#171717") forState:UIControlStateNormal];
        [radioBtn setTitleColor:COLOR(@"#206EEA") forState:UIControlStateSelected];
        [radioBtn setBackgroundImage:[UIImage imageWithColor:COLOR(@"#F5F5F5")] forState:UIControlStateNormal];
        [radioBtn setBackgroundImage:[UIImage imageWithColor:COLOR(@"#EEF4FF")] forState:UIControlStateSelected];
        radioBtn.tag = 10000 + i;
        ViewRadius(radioBtn, 5);
        @weakify(self);
        [[radioBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            RadioButton* button = x;
//            ViewBorderRadius(button, 5, 1, COLOR(@"#206EEA"));
            xw_DictModel* tm = array[button.tag - 10000];
            self.model.status = tm.code;

        }];
        [self.contentView addSubview:radioBtn];
        radioBtn.sd_layout
        .topSpaceToView(self.acceptStateNameLabel, 0)
        .leftSpaceToView(self.contentView, i* 65 + 20)
        .widthIs(60).heightIs(35);
        [self.buttons addObject:radioBtn];
        if([self.model.status isEqualToString:tm.code]){
            index = i;
        }
        
    }
    [self.buttons[0] setGroupButtons:self.buttons];
    
    if(self.model.status != nil){
        [self.buttons[index] setSelected:YES];
    }
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
-(UILabel*)acceptStateNameLabel{
    if (!_acceptStateNameLabel) {
        _acceptStateNameLabel = [UILabel labelWithText:@"受理状态" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _acceptStateNameLabel;
}

//-(UITextField*)acceptUserNameTextField{
//    if(!_acceptUserNameTextField){
//        _acceptUserNameTextField = [UITextField new];
//        _acceptUserNameTextField.font = FONT(13);
//        _acceptUserNameTextField.textColor = COLOR(@"#171717");
//        _acceptUserNameTextField.textAlignment = NSTextAlignmentLeft;
//        _acceptUserNameTextField.placeholder = @"请输入受理人员";
//        _acceptUserNameTextField.backgroundColor = COLOR(@"#F5F5F5");
//        ViewRadius(_acceptUserNameTextField, 5);
//    }
//    return _acceptUserNameTextField;
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self endEditing:YES];
    if(textField == self.createTimeTextField ){
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
-(NSMutableArray*)buttons{
    if(!_buttons){
        _buttons = [NSMutableArray arrayWithCapacity:2];
    }
    return _buttons;
}
@end
