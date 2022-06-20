//
//  xw_DelegateRecordCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import "xw_DelegateRecordCell.h"


@interface xw_DelegateRecordCell ()
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UILabel* busCategoryLabel;
@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UILabel* specLabel;
@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UILabel* addressLabel;
@property(nonatomic,strong)UILabel* line;

@property(nonatomic,strong)UIView* stateBgView;
@property(nonatomic,strong)UILabel* inspectResultLabel;
@property(nonatomic,strong)UILabel* acceptUserNameLabel;
@property(nonatomic,strong)UILabel* acceptUserPhoneLabel;

@end
@implementation xw_DelegateRecordCell
-(void)xw_setupUI{
    [self addSubview:self.snLabel];
    [self addSubview:self.busCategoryLabel];
    [self addSubview:self.sampleNameLabel];
    [self addSubview:self.specLabel];
    [self addSubview:self.createTimeLabel];
    [self addSubview:self.inspectOrgLabel];
    [self addSubview:self.addressLabel];
    
    
    [self addSubview:self.stateBgView];
    
    [self.stateBgView addSubview:self.inspectResultLabel];
    [self.stateBgView addSubview:self.acceptUserNameLabel];
    [self.stateBgView addSubview:self.acceptUserPhoneLabel];
    [self.stateBgView addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.snLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self, 5)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    self.busCategoryLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self.snLabel, 0)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    self.sampleNameLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self.busCategoryLabel, 0)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    self.specLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self.sampleNameLabel, 0)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    self.createTimeLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self.specLabel, 0)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    self.inspectOrgLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self.createTimeLabel, 0)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    self.addressLabel.sd_layout
    .leftSpaceToView(self, 10)
    .topSpaceToView(self.inspectOrgLabel, 0)
    .rightSpaceToView(self, 10)
    .heightIs(30);
    
    
    
    self.stateBgView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.addressLabel, 0)
    .heightIs(90);
    
    self.inspectResultLabel.sd_layout
    .leftSpaceToView(self.stateBgView, 10)
    .topEqualToView(self.stateBgView)
    .rightSpaceToView(self.stateBgView, 10)
    .heightIs(30);
    
    self.acceptUserNameLabel.sd_layout
    .leftSpaceToView(self.stateBgView, 10)
    .topSpaceToView(self.inspectResultLabel, 0)
    .rightSpaceToView(self.stateBgView, 10)
    .heightIs(30);
    
    self.acceptUserPhoneLabel.sd_layout
    .leftSpaceToView(self.stateBgView, 10)
    .topSpaceToView(self.acceptUserNameLabel, 0)
    .rightSpaceToView(self.stateBgView, 10)
    .heightIs(30);
    
    self.line.sd_layout
    .leftEqualToView(self.stateBgView)
    .topEqualToView(self.stateBgView)
    .rightEqualToView(self.stateBgView)
    .heightIs(1);
    
}
-(void)setModel:(xw_EntrustInspectModel *)model{
    self.snLabel.text = [NSString stringWithFormat:@"检测编号:%@",model.sn];
    self.busCategoryLabel.text = [NSString stringWithFormat:@"业务类型:%@",[xw_DataParsingHelper GetDictNameBySubCode:@"BUS_CATEGORY" subCode:model.busCategory]];
    self.sampleNameLabel.text = [NSString stringWithFormat:@"样品名称:%@",model.sampleName];
    self.specLabel.text = [NSString stringWithFormat:@"规格型号:%@",model.spec];
    self.createTimeLabel.text = [NSString stringWithFormat:@"申请时间:%@",model.createTime];
    self.inspectOrgLabel.text = [NSString stringWithFormat:@"检测机构:%@",[xw_DataParsingHelper getSingleOrgsNameById: model.inspectOrgId]];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",model.producerAddress];
    
    if([model.inspectResult isEqualToString:@"WAIT"]){
        self.stateBgView.hidden = YES;
    } else {
        self.stateBgView.hidden = NO;
        NSString* inspectResult= [NSString stringWithFormat:@"检测结果:%@",[xw_DataParsingHelper GetDictNameBySubCode:@"INSPECT_RESULT" subCode:model.inspectResult]];
        NSString *color ;
        if([model.inspectResult isEqualToString:@"ING"]){
            color = @"#FF8800";
        } else {
            color = @"#4CCD94";
        }
        self.inspectResultLabel.attributedText = [NSAttributedString getAttributeWith:[xw_DataParsingHelper GetDictNameBySubCode:@"INSPECT_RESULT" subCode:model.inspectResult]  string:inspectResult orginFont:FONT(13) orginColor:COLOR(@"#2C2C2B") attributeFont:FONT(13) attributeColor:COLOR(color) textAlignment:NSTextAlignmentLeft];
        self.acceptUserNameLabel.text = [NSString stringWithFormat:@"接待人员:%@",model.acceptUserName];
        self.acceptUserPhoneLabel.text = [NSString stringWithFormat:@"联系电话:%@",model.acceptUserPhone];
    }
    
}

-(UILabel*)snLabel{
    if (!_snLabel) {
        _snLabel = [UILabel new];
        _snLabel.textColor = COLOR(@"#2C2C2B");
        _snLabel.font = FONT(13);
        _snLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _snLabel;
}
-(UILabel*)busCategoryLabel{
    if (!_busCategoryLabel) {
        _busCategoryLabel = [UILabel new];
        _busCategoryLabel.textColor = COLOR(@"#2C2C2B");
        _busCategoryLabel.font = FONT(13);
        _busCategoryLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _busCategoryLabel;
}
-(UILabel*)sampleNameLabel{
    if (!_sampleNameLabel) {
        _sampleNameLabel = [UILabel new];
        _sampleNameLabel.textColor = COLOR(@"#2C2C2B");
        _sampleNameLabel.font = FONT(13);
        _sampleNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sampleNameLabel;
}
-(UILabel*)specLabel{
    if (!_specLabel) {
        _specLabel = [UILabel new];
        _specLabel.textColor = COLOR(@"#2C2C2B");
        _specLabel.font = FONT(13);
        _specLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _specLabel;
}
-(UILabel*)createTimeLabel{
    if (!_createTimeLabel) {
        _createTimeLabel = [UILabel new];
        _createTimeLabel.textColor = COLOR(@"#2C2C2B");
        _createTimeLabel.font = FONT(13);
        _createTimeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _createTimeLabel;
}
-(UILabel*)inspectOrgLabel{
    if (!_inspectOrgLabel) {
        _inspectOrgLabel = [UILabel new];
        _inspectOrgLabel.textColor = COLOR(@"#2C2C2B");
        _inspectOrgLabel.font = FONT(13);
        _inspectOrgLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _inspectOrgLabel;
}
-(UILabel*)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.textColor = COLOR(@"#2C2C2B");
        _addressLabel.font = FONT(13);
        _addressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLabel;
}
-(UIView*)stateBgView{
    if(!_stateBgView){
        _stateBgView = [UIView new];
    }
    return _stateBgView;
}
-(UILabel*)inspectResultLabel{
    if (!_inspectResultLabel) {
        _inspectResultLabel = [UILabel new];
        _inspectResultLabel.textColor = COLOR(@"#2C2C2B");
        _inspectResultLabel.font = FONT(13);
        _inspectResultLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _inspectResultLabel;
}
-(UILabel*)acceptUserNameLabel{
    if (!_acceptUserNameLabel) {
        _acceptUserNameLabel = [UILabel new];
        _acceptUserNameLabel.textColor = COLOR(@"#2C2C2B");
        _acceptUserNameLabel.font = FONT(13);
        _acceptUserNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _acceptUserNameLabel;
}
-(UILabel*)acceptUserPhoneLabel{
    if (!_acceptUserPhoneLabel) {
        _acceptUserPhoneLabel = [UILabel new];
        _acceptUserPhoneLabel.textColor = COLOR(@"#2C2C2B");
        _acceptUserPhoneLabel.font = FONT(13);
        _acceptUserPhoneLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _acceptUserPhoneLabel;
}
-(UILabel*)line{
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}
@end
