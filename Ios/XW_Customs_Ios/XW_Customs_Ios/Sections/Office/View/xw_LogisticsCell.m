//
//  xw_LogisticsCell.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import "xw_LogisticsCell.h"
@interface xw_LogisticsCell ()
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,strong)UILabel* statusLabel;
@property(nonatomic,strong)UIImageView* iconImageView;
@property(nonatomic,strong)UILabel* verticalLine;
@property(nonatomic,strong)UILabel* line;
@end
@implementation xw_LogisticsCell

-(void)xw_setupUI{
    [self addSubview:self.timeLabel];
    [self addSubview:self.statusLabel];
    [self addSubview:self.verticalLine];
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.timeLabel.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(100);
    
    self.verticalLine.sd_layout
    .centerXEqualToView(self.iconImageView)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(1);
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.timeLabel, 0)
    .centerYEqualToView(self)
    .widthIs(20).heightIs(20);
    
    
    
    self.statusLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 4)
    .rightSpaceToView(self, 5)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    self.line.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(1);
}
-(void)setModel:(ListModel *)model{
 
    NSString* color;
    if(self.row == 0){
        color = @"#206EEA";
        self.iconImageView.image = IMG(@"icon_logistics_complete");
        self.statusLabel.textColor = COLOR(@"#206EEA");
    } else {
        color = @"#838383";
        self.iconImageView.image = IMG(@"icon_logistics_un_complete");
        self.statusLabel.textColor = COLOR(@"#838383");
    }
    NSArray *arr = [model.time componentsSeparatedByString:@" "];
    NSString * timeString = [arr componentsJoinedByString:@"\n"];
    self.timeLabel.attributedText =  [NSAttributedString getAttributeWith:arr[0]  string:timeString orginFont:FONT(15) orginColor:COLOR(color) attributeFont:FONT(10) attributeColor:COLOR(color) textAlignment:NSTextAlignmentCenter];
    self.statusLabel.text = model.status;
}
-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        
    }
    return _iconImageView;
}
-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = FONT(15);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}
-(UILabel*)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = FONT(15);
        _statusLabel.textAlignment = NSTextAlignmentLeft;
        _statusLabel.numberOfLines = 0;
    }
    return _statusLabel;
}
-(UILabel*)verticalLine{
    if (!_verticalLine) {
        _verticalLine = [UILabel new];
        _verticalLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _verticalLine;
}
-(UILabel*)line{
    if (!_line) {
        _line = [UILabel new];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _line;
}

@end
