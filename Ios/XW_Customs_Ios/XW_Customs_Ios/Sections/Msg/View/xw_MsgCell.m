//
//  xw_MsgCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import "xw_MsgCell.h"
@interface xw_MsgCell ()
@property(nonatomic,strong)UIImageView *iconImageView;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *bageLabel;
@property(nonatomic,strong)UILabel* line;
@end
@implementation xw_MsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)xw_setupUI{
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bageLabel];
    [self addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .centerYEqualToView(self.contentView)
    .widthIs(25).heightIs(25);
    
   
    
    
    self.timeLabel.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 15)
    .widthIs(150).heightIs(30);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 20)
    .topSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.timeLabel, 10)
    .heightIs(30);
    
    self.bageLabel.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.timeLabel, 17)
    .widthIs(6)
    .heightIs(6);
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 20)
    .topSpaceToView(self.titleLabel, 0)
    .rightSpaceToView(self.bageLabel, 10)
    .heightIs(30);
    
    self.line.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(1);
}
//-(void)setModel:(xw_HomeTypeModel *)model{
//    self.iconImageView.image = [UIImage imageNamed:model.icon];
//    self.titleLabel.text = model.title;
//}

-(void)setModel:(xw_MsgModel *)model{

    if ([model.type isEqualToString:@"SYSTEM"]){
        self.iconImageView.image = IMG(@"icon_msg_system");
    } else if ([model.type isEqualToString:@"ACCEPT"]){
        self.iconImageView.image = IMG(@"icon_msg_receive");
    } else if ([model.type isEqualToString:@"DISPATCH"]){
        self.iconImageView.image = IMG(@"icon_msg_order");
    }
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.createTime;
    self.contentLabel.text = model.content;
    
    if(model.readFlag){
        self.bageLabel.hidden = YES;
        
    } else {
        self.bageLabel.hidden = NO;
        
    }
}
#pragma make 懒加载

-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"业务通知" WithTextColor:COLOR(@"#2C2C2B") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:16];

    }
    return _titleLabel;
}
-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"2020-03-08" WithTextColor:COLOR(@"#9B9A9A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentRight WithFont:12];

    }
    return _timeLabel;
}
-(UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"本次申请的(畹町口岸)入境业务已经办理至本次申请的(畹町口岸)入境业务已经办理至......" WithTextColor:COLOR(@"#9B9A9A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:13];

    }
    return _contentLabel;
}
-(UILabel*)bageLabel{
    if (!_bageLabel) {
        _bageLabel = [UILabel new];
        _bageLabel.backgroundColor = COLOR(@"#FF3333");
        ViewRadius(_bageLabel, 3);

    }
    return _bageLabel;
}
-(UILabel*)line{
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}
@end
