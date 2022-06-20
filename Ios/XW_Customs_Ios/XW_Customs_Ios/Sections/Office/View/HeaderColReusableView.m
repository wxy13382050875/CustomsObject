//
//  HeaderColReusableView.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "HeaderColReusableView.h"
@interface HeaderColReusableView ()
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIButton* moreBtn;
@property(nonatomic,strong)UIView* line;
@end
@implementation HeaderColReusableView
-(void)xw_setupUI{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
//    [self addSubview:self.moreBtn];
    [self addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.imageView.sd_layout
    .leftSpaceToView(self, 10)
    .centerYEqualToView(self)
    .widthIs(20)
    .heightIs(20);
    
//    self.moreBtn.sd_layout
//    .rightSpaceToView(self, 10)
//    .topEqualToView(self)
//    .bottomEqualToView(self)
//    .widthIs(105);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.imageView, 5)
    .rightSpaceToView(self, 10)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    self.line.sd_layout
    .leftSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .bottomEqualToView(self)
    .heightIs(1);
    
}
-(void)setModel:(MobilepermissiontreeModel *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:IMG(@"icon_default_placeholder")];
    self.titleLabel.text = model.name;
}
#pragma mark 懒加载
-(UIImageView*)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = IMG(@"icon_faq");
    }
    return _imageView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR(@"#2A2A2A");
        _titleLabel.font = FONT(17);
        _titleLabel.text = @"常见问题";
    }
    return _titleLabel;
}
-(UIButton*)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithTitie:@"查看更多>>" WithtextColor:COLOR(@"#2A2A2A") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:12 EventBlock:^(id  _Nonnull params) {
            
//            if (self.didChickEventBlock) {
//                self.didChickEventBlock(self.bModel);
//            }
        }];
//        [_moreBtn layoutWithStatus:XWLayoutStatusImageRight andMargin:35];
    }
    return _moreBtn;
}
-(UIView*)line{
    if(!_line){
        _line = [UIView new];
        _line.backgroundColor = COLOR(@"#E8E8E8");
    }
    return _line;
}
@end
