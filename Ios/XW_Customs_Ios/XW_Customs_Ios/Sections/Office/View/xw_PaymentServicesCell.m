//
//  xw_PaymentServicesCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/14.
//

#import "xw_PaymentServicesCell.h"

@interface xw_PaymentServicesCell ()

@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIImageView* qrImageView;
@property(nonatomic,strong)UILabel* descLabel;



@end
@implementation xw_PaymentServicesCell

-(void)xw_setupUI{
    self.xw_height= SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 5;

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.qrImageView];

    [self.contentView addSubview:self.descLabel];
    
    
}
-(void)xw_updateConstraints{
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 60)
    .heightIs(60);
    
    self.qrImageView.sd_layout
    .topSpaceToView(self.titleLabel, 15)
    .centerXEqualToView(self.contentView)
    .heightIs(100).widthIs(100);

    self.descLabel.sd_layout
        .leftSpaceToView(self.contentView, 20)
        .rightSpaceToView(self.contentView, 20)
        .topSpaceToView(self.qrImageView, 5)
        .heightIs(35);
    
    
}

-(void)setQrCode:(NSString *)qrCode{
    NSURL *url = [NSURL URLWithString:qrCode];
    [self.qrImageView sd_setImageWithURL:url placeholderImage:IMG(@"icon_default_placeholder")];
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"委托单位可以通过\n扫描下方二维码进行缴费" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:2 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:15];
    }
    return _titleLabel;
}
-(UIImageView*)qrImageView{
    if (!_qrImageView) {
        _qrImageView = [UIImageView new];
        _qrImageView.image = IMG(@"centre_test");
    }
    return _qrImageView;
}
-(UILabel*)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel labelWithText:@"【长按识别二维码支付】" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:12];
    }
    return _descLabel;
}

@end
