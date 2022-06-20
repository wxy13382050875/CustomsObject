//
//  xw_CertQrCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_CertQrCell.h"

@interface xw_CertQrCell ()

@property(nonatomic,strong)UIImageView* qrImageView;



@end
@implementation xw_CertQrCell

-(void)xw_setupUI{
    self.xw_height= SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 5;

    [self.contentView addSubview:self.qrImageView];

    
    
}
-(void)xw_updateConstraints{
    
    
    self.qrImageView.sd_layout
    .topSpaceToView(self.contentView, 100)
    .centerXEqualToView(self.contentView)
    .heightIs(100).widthIs(100);


    
}

-(void)setQrCode:(NSString *)qrCode{
    NSURL *url = [NSURL URLWithString:qrCode];
    [self.qrImageView sd_setImageWithURL:url placeholderImage:IMG(@"icon_default_placeholder")];
}


-(UIImageView*)qrImageView{
    if (!_qrImageView) {
        _qrImageView = [UIImageView new];
        _qrImageView.image = IMG(@"centre_test");
    }
    return _qrImageView;
}

@end
