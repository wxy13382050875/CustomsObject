//
//  xw_CeneralListCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "xw_CeneralListCell.h"
@interface xw_CeneralListCell ()
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UIImageView* arrowimage;
@end
@implementation xw_CeneralListCell

-(void)xw_setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowimage];
}
-(void)xw_updateConstraints{
    
    self.arrowimage.sd_layout
    .rightSpaceToView(self, 10)
    .centerYEqualToView(self)
    .widthIs(24).heightIs(24);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self.arrowimage, 20)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    
}
-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
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

-(UIImageView*)arrowimage{
    if (!_arrowimage) {
        _arrowimage = [UIImageView new];
        _arrowimage.image = IMG(@"icon_right_arrow");
        
    }
    return _arrowimage;
}

@end
