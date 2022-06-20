//
//  xw_CertificateCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import "xw_CertificateCell.h"
@interface xw_CertificateCell ()
@property(nonatomic,strong)UIImageView* iconImageview;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* descLabel;
@property(nonatomic,strong)UIImageView* arrowimage;

@property(nonatomic,strong)UILabel* line;
@end
@implementation xw_CertificateCell
-(void)xw_setupUI{
    [self addSubview:self.iconImageview];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.arrowimage];
    [self addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.iconImageview.sd_layout
    .leftSpaceToView(self, 10)
    .centerYEqualToView(self)
    .widthIs(30).heightIs(34);
    
    self.arrowimage.sd_layout
    .rightSpaceToView(self, 20)
    .centerYEqualToView(self)
    .widthIs(24).heightIs(24);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageview, 10)
    .rightSpaceToView(self.arrowimage, 20)
    .topSpaceToView(self, 20)
    .heightIs(30);
    
    self.descLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .bottomSpaceToView(self, 20)
    .heightIs(20);
    
    self.line.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(1);
}
-(void)setModel:(xw_EntrustInspectModel *)model{
 
    self.titleLabel.text = [NSString stringWithFormat:@"检测编号:%@",model.sn];
    self.descLabel.text = [NSString stringWithFormat:@"申请时间:%@",model.createTime];
}
-(UIImageView*)iconImageview{
    if (!_iconImageview) {
        _iconImageview = [UIImageView new];
        _iconImageview.image = IMG(@"icon_certificate");
        
    }
    return _iconImageview;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR(@"#2A2A2A");
        _titleLabel.font = FONT(15);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel*)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = COLOR(@"#7E7E7E");
        _descLabel.font = FONT(12);
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}
-(UIImageView*)arrowimage{
    if (!_arrowimage) {
        _arrowimage = [UIImageView new];
        _arrowimage.image = IMG(@"icon_right_arrow");
        
    }
    return _arrowimage;
}
-(UILabel*)line{
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}

@end
