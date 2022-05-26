//
//  CentreColCell.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "CentreColCell.h"
@interface CentreColCell ()

@property(nonatomic,strong)UIImageView* imageview;
@end
@implementation CentreColCell
-(void)xw_setupUI{
    [self addSubview:self.imageview];
}
-(void)xw_updateConstraints{
    self.imageview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 5, 0, 5)) ;
    
    
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
        _imageview.image = IMG(@"centre_test");
        
    }
    return _imageview;
}

@end
