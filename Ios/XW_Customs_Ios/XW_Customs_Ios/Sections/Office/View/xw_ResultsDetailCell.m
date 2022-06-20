//
//  xw_ResultsDetailCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_ResultsDetailCell.h"
#import "RadioButton.h"
@interface xw_ResultsDetailCell ()
@property(nonatomic,strong)UILabel* takeWayLabel;
@property(nonatomic,strong)NSMutableArray* buttons;

@property(nonatomic,strong)UILabel* expressNoLabel;
@property(nonatomic,strong)UITextField* expressNoTextField;
@property(nonatomic,strong)UIButton* scanBtn;
@end
@implementation xw_ResultsDetailCell

-(void)xw_setupUI{
    self.xw_height= SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 5;

    [self.contentView addSubview:self.takeWayLabel];
    [self.contentView addSubview:self.expressNoLabel];
    [self.contentView addSubview:self.expressNoTextField];
    [self.contentView addSubview:self.scanBtn];

    
    
}
-(void)xw_updateConstraints{
    
    
    self.takeWayLabel.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .topSpaceToView(self.contentView, 5)
    .heightIs(35).widthIs(120);
    
  
    
    self.expressNoLabel.sd_layout
    .leftSpaceToView(self.contentView, 5)
    .topSpaceToView(self.takeWayLabel, 5)
    .heightIs(35).widthIs(80);
    
    self.scanBtn.sd_layout
    .topEqualToView(self.expressNoLabel)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(35).widthIs(35);
    
    self.expressNoTextField.sd_layout
    .leftSpaceToView(self.takeWayLabel, 5)
    .rightSpaceToView(self.scanBtn, 5)
    .topEqualToView(self.expressNoLabel)
    .heightIs(35);

    
}

-(void)setModel:(xw_EntrustInspectModel *)model{
    _model = model;
    self.expressNoTextField.text = _model.expressNo;
    
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
            self.expressNoTextField.text = @"";
            if([self.model.takeWay isEqualToString:@"SELF_TAKE"]){
                self.expressNoTextField.enabled = NO;
                self.scanBtn.enabled = NO;
            } else {
                self.expressNoTextField.enabled = YES;
                self.scanBtn.enabled = YES;
            }

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



-(UILabel*)takeWayLabel{
    if (!_takeWayLabel) {
        _takeWayLabel = [UILabel labelWithText:@"报告拿取方式" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _takeWayLabel;
}

-(UILabel*)expressNoLabel{
    if (!_expressNoLabel) {
        _expressNoLabel = [UILabel labelWithText:@"快递单号" WithTextColor:COLOR(@"#171717") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:15];
    }
    return _expressNoLabel;
}
-(UITextField*)expressNoTextField{
    if(!_expressNoTextField){
        _expressNoTextField = [UITextField new];
        _expressNoTextField.font = FONT(13);
        _expressNoTextField.textColor = COLOR(@"#171717");
        _expressNoTextField.textAlignment = NSTextAlignmentLeft;
        _expressNoTextField.placeholder = @"请输入检测编号";
        _expressNoTextField.backgroundColor = COLOR(@"#F5F5F5");
        [_expressNoTextField setTextFieldLeftPadding:10];
        @weakify(self);
        [_expressNoTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.expressNo = x;
        }];
        ViewRadius(_expressNoTextField, 5);
        _expressNoTextField.enabled = NO;
    }
    return _expressNoTextField;
}
-(NSMutableArray*)buttons{
    if(!_buttons){
        _buttons = [NSMutableArray arrayWithCapacity:2];
    }
    return _buttons;
}
- (UIButton *)scanBtn {
    if (!_scanBtn) {
        _scanBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:nil WithImage:IMG(@"icon_nav_scan") WithFont:15 EventBlock:^(id  _Nonnull params) {
            if(self.scanDataBlock){
                self.scanDataBlock();
            }
        }];
        _scanBtn.enabled = NO;
     }
    return _scanBtn;
}
@end
