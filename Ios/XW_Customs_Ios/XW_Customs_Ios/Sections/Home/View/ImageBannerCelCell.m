//
//  ImageBannerCelCell.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "ImageBannerCelCell.h"
@interface ImageBannerCelCell ()

@property(nonatomic,strong)UIImageView* imageview;
@end
@implementation ImageBannerCelCell
-(void)xw_setupUI{
    [self addSubview:self.imageview];
}
-(void)xw_updateConstraints{
    self.imageview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0)) ;
    
    
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
        _imageview.image = IMG(@"banner");
        
    }
    return _imageview;
}
@end
