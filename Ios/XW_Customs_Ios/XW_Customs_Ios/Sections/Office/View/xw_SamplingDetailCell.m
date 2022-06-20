//
//  xw_SamplingDetailCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_SamplingDetailCell.h"
#import "xw_UserInfoModel.h"
#import "RadioButton.h"
@interface xw_SamplingDetailCell ()
@property(nonatomic,strong)UILabel* sampleWayLabel;
@property(nonatomic,strong)NSMutableArray* buttons;

@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UITextField* inspectOrgTextField;

@property(nonatomic,strong)UILabel* samplingTimeLabel;
@property(nonatomic,strong)UITextField* samplingTimeTextField;

@property(nonatomic,strong)UILabel* samplingUserNameLabel;
@property(nonatomic,strong)UITextField* samplingUserNameTextField;

@property(nonatomic,strong)UILabel* samplingNoteLabel;
@property(nonatomic,strong)UITextView* samplingNoteTextView;
@end
@implementation xw_SamplingDetailCell

-(void)xw_setupUI{
    self.xw_height= SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 5;

    [self.contentView addSubview:self.sampleWayLabel];
    
    [self.contentView addSubview:self.inspectOrgLabel];
    [self.contentView addSubview:self.inspectOrgTextField];
    
    [self.contentView addSubview:self.samplingTimeLabel];
    [self.contentView addSubview:self.samplingTimeTextField];
    
    [self.contentView addSubview:self.samplingUserNameLabel];
    [self.contentView addSubview:self.samplingUserNameTextField];
    
    [self.contentView addSubview:self.samplingNoteLabel];
    [self.contentView addSubview:self.samplingNoteTextView];
}
-(void)xw_updateConstraints{
    
    
    self.sampleWayLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 5)
    .heightIs(35).widthIs(120);
    
  
    
    self.inspectOrgLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.sampleWayLabel, 5)
    .heightIs(35).widthIs(80);
    
    self.inspectOrgTextField.sd_layout
    .leftSpaceToView(self.inspectOrgLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.inspectOrgLabel)
    .heightIs(35);
    
    self.samplingTimeLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.inspectOrgLabel, 5)
    .heightIs(35).widthIs(80);
    
    self.samplingTimeTextField.sd_layout
    .leftSpaceToView(self.samplingTimeLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.samplingTimeLabel)
    .heightIs(35);

    self.samplingUserNameLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.samplingTimeLabel, 5)
    .heightIs(35).widthIs(80);
    
    self.samplingUserNameTextField.sd_layout
    .leftSpaceToView(self.samplingUserNameLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.samplingUserNameLabel)
    .heightIs(35);
    
    self.samplingNoteLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.samplingUserNameLabel, 5)
    .heightIs(35).widthIs(80);
    
    self.samplingNoteTextView.sd_layout
    .leftSpaceToView(self.samplingNoteLabel, 5)
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.samplingNoteLabel)
    .heightIs(100);
    
}

-(void)setModel:(xw_EntrustInspectModel *)model{
    _model = model;
    self.inspectOrgTextField.text = [xw_DataParsingHelper getSingleOrgsNameById:_model.inspectOrgId];
    self.samplingTimeTextField.text = _model.samplingTime;
    
    xw_UserInfoModel* userModel = [xw_UserInfoModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].sUserInfo];
    self.samplingUserNameTextField.text = userModel.trueName;
    self.samplingNoteTextView.text = _model.samplingNote;
    
    [self.buttons removeAllObjects];
    NSArray* array = [xw_DataParsingHelper getDictItemByCode:@"SAMPLE_WAY"];
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
            self.model.sampleWay = tm.code;
            

        }];
        [self.contentView addSubview:radioBtn];
        radioBtn.sd_layout
        .leftSpaceToView(self.sampleWayLabel, i* 80 + 5)
        .centerYEqualToView(self.sampleWayLabel)
        .widthIs(80).heightIs(35);
        [self.buttons addObject:radioBtn];
        if([self.model.takeWay isEqualToString:tm.code]){
            index = i;
        }
        
    }
    [self.buttons[0] setGroupButtons:self.buttons];
    if(self.model.sampleWay != nil){
        [self.buttons[index] setSelected:YES];
    }
}



-(UILabel*)sampleWayLabel{
    if (!_sampleWayLabel) {
        _sampleWayLabel = [UILabel labelWithText:@"采样方式" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _sampleWayLabel;
}

-(UILabel*)inspectOrgLabel{
    if (!_inspectOrgLabel) {
        _inspectOrgLabel = [UILabel labelWithText:@"检测机构" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _inspectOrgLabel;
}
-(UITextField*)inspectOrgTextField{
    if(!_inspectOrgTextField){
        _inspectOrgTextField = [UITextField new];
        _inspectOrgTextField.font = FONT(13);
        _inspectOrgTextField.textColor = COLOR(@"#171717");
        _inspectOrgTextField.textAlignment = NSTextAlignmentLeft;
        [_inspectOrgTextField setTextFieldLeftPadding:10];
        _inspectOrgTextField.enabled = NO;
    }
    return _inspectOrgTextField;
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
        [_samplingTimeTextField setTextFieldLeftPadding:10];
        _samplingTimeTextField.enabled = NO;
    }
    return _samplingTimeTextField;
}
-(UILabel*)samplingUserNameLabel{
    if (!_samplingUserNameLabel) {
        _samplingUserNameLabel = [UILabel labelWithText:@"采样人员" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _samplingUserNameLabel;
}
-(UITextField*)samplingUserNameTextField{
    if(!_samplingUserNameTextField){
        _samplingUserNameTextField = [UITextField new];
        _samplingUserNameTextField.font = FONT(13);
        _samplingUserNameTextField.textColor = COLOR(@"#171717");
        _samplingUserNameTextField.textAlignment = NSTextAlignmentLeft;
        [_samplingUserNameTextField setTextFieldLeftPadding:10];
        _samplingUserNameTextField.enabled = NO;
    }
    return _samplingUserNameTextField;
}
-(UILabel*)samplingNoteLabel{
    if (!_samplingNoteLabel) {
        _samplingNoteLabel = [UILabel labelWithText:@"备注" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _samplingNoteLabel;
}
-(UITextView*)samplingNoteTextView{
    if(!_samplingNoteTextView){
        _samplingNoteTextView = [UITextView new];
        _samplingNoteTextView.backgroundColor=COLOR(@"#EEEEEE"); //设置背景色
        _samplingNoteTextView.scrollEnabled = NO;    //设置当文字超过视图的边框时是否允许滑动，默认为“YES”
        _samplingNoteTextView.editable = YES;        //设置是否允许编辑内容，默认为“YES”
    //        textview.delegate = self;       //设置代理方法的实现类
        _samplingNoteTextView.font=[UIFont fontWithName:@"Arial" size:12.0]; //设置字体名字和字体大小;
        _samplingNoteTextView.returnKeyType = UIReturnKeyDefault;//设置return键的类型
        _samplingNoteTextView.keyboardType = UIKeyboardTypeDefault;//设置键盘类型一般为默认
        _samplingNoteTextView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        _samplingNoteTextView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
        _samplingNoteTextView.textColor = [UIColor blackColor];// 设置显示文字颜色
        _samplingNoteTextView.text = @"";//设置显示的文本内容
        
        _samplingNoteTextView.xw_placeHolderTextView.textColor = COLOR(@"#AAB3BA");
        [_samplingNoteTextView xw_addPlaceHolder:@"请在此处填写备注内容"];
        
        @weakify(self);
      
        _samplingNoteTextView.block = ^(NSString * _Nonnull text) {
            @strongify(self);
            self.model.samplingNote = text;
        };
        ViewRadius(_samplingNoteTextView, 5);
    }
    return _samplingNoteTextView;
}
-(NSMutableArray*)buttons{
    if(!_buttons){
        _buttons = [NSMutableArray arrayWithCapacity:2];
    }
    return _buttons;
}


@end
