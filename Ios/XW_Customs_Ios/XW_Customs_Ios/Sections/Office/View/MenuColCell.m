//
//  MenuColCell.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "MenuColCell.h"
@interface MenuColCell ()
@property (nonatomic, strong) UIView *bgView;
@property(nonatomic,strong)UIImageView* imageview;
@property(nonatomic,strong)UILabel* titleLabel;
@end
@implementation MenuColCell
-(void)xw_setupUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.imageview];
    [self.bgView addSubview:self.titleLabel];
}
-(void)xw_updateConstraints{
    self.bgView.sd_layout
    .topSpaceToView(self, 5)
    .leftSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .bottomSpaceToView(self, 5);
    
    self.imageview.sd_layout
    .topSpaceToView(self.bgView, 15)
    .centerXEqualToView(self.bgView)
    .widthIs(30)
    .heightIs(30);
    
    self.titleLabel.sd_layout
    .leftEqualToView(self.bgView)
    .rightEqualToView(self.bgView)
    .topSpaceToView(self.imageview, 5)
    .bottomSpaceToView(self.bgView, 5);
    
    
}
-(void)setModel:(SubTreeModel *)model{
    if(model.localIcon != nil){
        self.imageview.image = IMG(model.localIcon);
    } else {
        [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:IMG(@"icon_default_placeholder")];
    }
    
    self.titleLabel.text = model.name;
}
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

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = COLOR(@"#F0F5FD");
        ViewRadius(_bgView, 10);
    }
    return _bgView;
}

@end
