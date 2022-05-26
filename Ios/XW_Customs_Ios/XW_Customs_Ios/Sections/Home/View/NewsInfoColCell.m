//
//  NewsInfoColCell.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "NewsInfoColCell.h"
@interface NewsInfoColCell ()
@property(nonatomic,strong)UIImageView* imageview;
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UITextField* readTextField;
@property(nonatomic,strong)UITextField* updateTextField;
@property(nonatomic,strong)UIView* line;
@end
@implementation NewsInfoColCell
-(void)xw_setupUI{
    [self addSubview:self.imageview];
    [self addSubview:self.titleLabel];
    [self addSubview:self.readTextField];
    [self addSubview:self.updateTextField];
    [self addSubview:self.line];
}
-(void)xw_updateConstraints{
    self.imageview.sd_layout
    .rightSpaceToView(self, 10)
    .centerYEqualToView(self)
    .widthIs(107)
    .heightIs(64);
    
    self.titleLabel.sd_layout
    .rightSpaceToView(self.imageview, 10)
    .topEqualToView(self.imageview)
    .leftSpaceToView(self, 10)
    .heightIs(42);
    
    self.readTextField.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel, 0)
    .bottomEqualToView(self.imageview)
    .widthIs(150);
    
    self.updateTextField.sd_layout
    .rightSpaceToView(self.imageview, 10)
    .topSpaceToView(self.titleLabel, 0)
    .bottomEqualToView(self.imageview)
    .widthIs(100);
    
    self.line.sd_layout
    .leftSpaceToView(self, 5)
    .rightSpaceToView(self, 5)
    .bottomEqualToView(self)
    .heightIs(1);
}

#pragma mark 懒加载
-(UIImageView*)imageview{
    if (!_imageview) {
        _imageview = [UIImageView new];
        _imageview.image = IMG(@"centre_test");
    }
    return _imageview;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = COLOR(@"#2A2A2A");
        _titleLabel.font = FONT(15);
        _titleLabel.text = @"关于沿边区加强经济建设治安管理指导文件";
        _titleLabel.numberOfLines =0;
    }
    return _titleLabel;
}
-(UITextField*)readTextField{
    if (!_readTextField) {
        _readTextField = [UITextField new];
        _readTextField.font = FONT(10);
        _readTextField.textColor = COLOR(@"#A1A1A1");
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_eye");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(16).heightIs(10);
        _readTextField.leftView = leftView;
        
        _readTextField.leftViewMode = UITextFieldViewModeAlways;
        _readTextField.enabled = NO;
        _readTextField.text = @"2020";
        _readTextField.textAlignment = NSTextAlignmentLeft;
    }
    return _readTextField;
}
-(UITextField*)updateTextField{
    if (!_updateTextField) {
        _updateTextField = [UITextField new];
        _updateTextField.font = FONT(10);
        _updateTextField.textColor = COLOR(@"#A1A1A1");
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_time");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(16).heightIs(16);
        _updateTextField.leftView = leftView;
        
        _updateTextField.leftViewMode = UITextFieldViewModeAlways;
        _updateTextField.enabled = NO;
        _updateTextField.text = @"2020-03-18";
        _updateTextField.textAlignment = NSTextAlignmentRight;
        
    }
    return _updateTextField;
}

-(UIView*)line{
    if(!_line){
        _line = [UIView new];
        _line.backgroundColor = COLOR(@"#E8E8E8");
    }
    return _line;
}
@end
