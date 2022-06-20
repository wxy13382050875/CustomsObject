//
//  xw_MsgGroupCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/6.
//

#import "xw_MsgGroupCell.h"
@interface xw_MsgGroupCell ()
@property(nonatomic,strong)UIImageView* imageview;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* descLabel;
@property(nonatomic,strong)UIImageView* arrowimage;

@property(nonatomic,strong)UILabel* line;
@end
@implementation xw_MsgGroupCell

-(void)xw_setupUI{
    [self addSubview:self.imageview];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.arrowimage];
    [self addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.imageView.sd_layout
    .leftSpaceToView(self, 20)
    .centerYEqualToView(self)
    .widthIs(24).heightIs(24);
    
    self.arrowimage.sd_layout
    .rightSpaceToView(self, 20)
    .centerYEqualToView(self)
    .widthIs(24).heightIs(24);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.imageView, 20)
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
-(void)setModel:(xw_MsgGroupModel *)model{
    
    if ([model.type isEqualToString:@"SYSTEM"]){
        self.imageView.image = IMG(@"icon_msg_system");
    } else if ([model.type isEqualToString:@"ACCEPT"]){
        self.imageView.image = IMG(@"icon_msg_receive");
    } else if ([model.type isEqualToString:@"DISPATCH"]){
        self.imageView.image = IMG(@"icon_msg_order");
    }
    self.titleLabel.text = [xw_DataParsingHelper GetDictNameBySubCode:@"MESSAGE_TYPE" subCode:model.type] ;
    self.descLabel.text = [NSString stringWithFormat:@"您有%@条%@消息未阅读",model.noRead,[xw_DataParsingHelper GetDictNameBySubCode:@"MESSAGE_TYPE" subCode:model.type]];
}
-(UIImageView*)imageview{
    if (!_imageview) {
        _imageview = [UIImageView new];
        _imageview.image = IMG(@"icon_msg_system");
        
    }
    return _imageview;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR(@"#2A2A2A");
        _titleLabel.font = FONT(13);
        _titleLabel.text = @"缴费服务";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
-(UILabel*)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textColor = COLOR(@"#2A2A2A");
        _descLabel.font = FONT(13);
        _descLabel.text = @"缴费服务";
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
