//
//  MenuColCell.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "MenuColCell.h"
@interface MenuColCell ()

@property(nonatomic,strong)UIImageView* imageview;
@property(nonatomic,strong)UILabel* titleLabel;
@end
@implementation MenuColCell
-(void)xw_setupUI{
    [self addSubview:self.imageview];
    [self addSubview:self.titleLabel];
}
-(void)xw_updateConstraints{
    self.imageview.sd_layout
    .topSpaceToView(self, 30)
    .centerXEqualToView(self)
    .widthIs(40)
    .heightIs(40);
    
    self.titleLabel.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, 5)
    .heightIs(40);
    
    
}
//-(void)setModel:(Banner *)model{
//    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:IMG(@"icon_default_placeholder")];
//}
//-(void)setNModel:(menuListModel *)nModel{
//    [self.imageview sd_setImageWithURL:[NSURL URLWithString:nModel.pictureUrl] placeholderImage:IMG(@"icon_default_placeholder")];
//}
#pragma mark 懒加载
-(UIImageView*)imageview{
    if (!_imageview) {
        _imageview = [UIImageView new];
        _imageview.image = IMG(@"menu_test");
        
    }
    return _imageview;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR(@"#2A2A2A");
        _titleLabel.font = FONT(13);
        _titleLabel.text = @"缴费服务";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
