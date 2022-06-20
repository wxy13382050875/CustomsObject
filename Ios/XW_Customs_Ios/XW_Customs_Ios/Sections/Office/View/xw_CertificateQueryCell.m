//
//  xw_CertificateQueryCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/14.
//

#import "xw_CertificateQueryCell.h"
@interface xw_CertificateQueryCell ()
@property(nonatomic,strong)UIImageView* logoImageView;
@property(nonatomic,strong)UILabel* snLabel;
@property(nonatomic,strong)UILabel* entrustOrgLabel;
@property(nonatomic,strong)UILabel* inspectOrgLabel;
@property(nonatomic,strong)UILabel* registerTimeLabel;
@property(nonatomic,strong)UILabel* line;
@property(nonatomic,strong)UILabel* bottomTitleLabel;
@end
@implementation xw_CertificateQueryCell

-(void)xw_setupUI{
    self.xw_height= SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 5;

    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.snLabel];
    [self.contentView addSubview:self.entrustOrgLabel];
    [self.contentView addSubview:self.inspectOrgLabel];
    [self.contentView addSubview:self.registerTimeLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.bottomTitleLabel];
}
-(void)xw_updateConstraints{
    
    self.logoImageView.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 100)
    .heightIs(90);
    
    self.snLabel.sd_layout
    .topSpaceToView(self.logoImageView, 0)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(35);

    self.entrustOrgLabel.sd_layout
    .topSpaceToView(self.snLabel, 0)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(35);
    
    self.inspectOrgLabel.sd_layout
    .topSpaceToView(self.entrustOrgLabel, 0)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(35);
    
    self.registerTimeLabel.sd_layout
    .topSpaceToView(self.inspectOrgLabel, 0)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(35);
    
    self.line.sd_layout
    .topSpaceToView(self.registerTimeLabel, 10)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(1);
    
    self.bottomTitleLabel.sd_layout
    .topSpaceToView(self.line, 10)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(80);
}

-(void)setModel:(xw_EntrustInspectModel *)model{
    self.snLabel.text = [NSString stringWithFormat:@"检验编号:%@",model.sn!=nil ? model.sn:@""];
    self.entrustOrgLabel.text = [NSString stringWithFormat:@"报检单位:%@",model.entrustOrgName!=nil ? model.entrustOrgName:@""];
    self.inspectOrgLabel.text = [NSString stringWithFormat:@"检测机构:%@",[xw_DataParsingHelper getSingleOrgsNameById:model.inspectOrgId]];
    self.registerTimeLabel.text = [NSString stringWithFormat:@"检验时间:%@",model.registerTime!=nil ? model.registerTime:@""];
}
-(UIImageView*)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = IMG(@"icon_certificate_logo");
    }
    return _logoImageView;
}
-(UILabel*)snLabel{
    if (!_snLabel) {
        _snLabel = [UILabel labelWithText:@"检验编号:" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:13];
    }
    return _snLabel;
}

-(UILabel*)entrustOrgLabel{
    if (!_entrustOrgLabel) {
        _entrustOrgLabel = [UILabel labelWithText:@"报检单位:" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:13];
    }
    return _entrustOrgLabel;
}
-(UILabel*)inspectOrgLabel{
    if (!_inspectOrgLabel) {
        _inspectOrgLabel = [UILabel labelWithText:@"检测机构:" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:13];
    }
    return _inspectOrgLabel;
}

-(UILabel*)registerTimeLabel{
    if (!_registerTimeLabel) {
        _registerTimeLabel = [UILabel labelWithText:@"检验时间:" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:13];
    }
    return _registerTimeLabel;
}
-(UILabel*)line{
    if (!_line) {
        _line = [UILabel labelWithText:@"" WithTextColor:nil WithNumOfLine:1 WithBackColor:COLOR(@"eeeeee") WithTextAlignment:NSTextAlignmentCenter WithFont:13];
    }
    return _line;
}
-(UILabel*)bottomTitleLabel{
    if (!_bottomTitleLabel) {
        _bottomTitleLabel = [UILabel labelWithText:@"2022年4月19日\n由昆明海关技术中心检测" WithTextColor:COLOR(@"#898989") WithNumOfLine:2 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:13];
    }
    return _bottomTitleLabel;
}
@end
