//
//  xw_MyCourierCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import "xw_MyCourierCell.h"
@interface xw_MyCourierCell ()
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UILabel* busCategoryLabel;
@property(nonatomic,strong)UILabel* sampleNameLabel;
@property(nonatomic,strong)UILabel* specLabel;
@property(nonatomic,strong)UILabel* createTimeLabel;
@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UILabel* line;
@end
@implementation xw_MyCourierCell
-(void)xw_setupUI{
    [self addSubview:self.snLabel];
    [self addSubview:self.busCategoryLabel];
    [self addSubview:self.sampleNameLabel];
    [self addSubview:self.specLabel];
    [self addSubview:self.createTimeLabel];
    [self addSubview:self.inspectOrgLabel];
    [self addSubview:self.line];
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
    
    self.line.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(1);
}
-(void)setModel:(xw_EntrustInspectModel *)model{
    self.snLabel.text = [NSString stringWithFormat:@"检测编号:%@",model.sn];
    self.busCategoryLabel.text = [NSString stringWithFormat:@"业务类型:%@",[xw_DataParsingHelper GetDictNameBySubCode:@"BUS_CATEGORY" subCode:model.busCategory]];
    self.sampleNameLabel.text = [NSString stringWithFormat:@"样品名称:%@",model.sampleName];
    self.specLabel.text = [NSString stringWithFormat:@"规格型号:%@",model.spec];
    self.createTimeLabel.text = [NSString stringWithFormat:@"申请时间:%@",model.createTime];
    self.inspectOrgLabel.text = [NSString stringWithFormat:@"检测机构:%@",[xw_DataParsingHelper getSingleOrgsNameById: model.inspectOrgId]];
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

-(UILabel*)line{
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}
@end
