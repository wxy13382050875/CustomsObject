//
//  xw_MsgDetailViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2020/5/9.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "MsgDetailViewController.h"
@interface MsgDetailViewController ()
@property(nonatomic,strong)UILabel* titleLabel;
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,strong)UILabel* contentLabel;
@end

@implementation MsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)xw_setupUI{
    self.view.backgroundColor = COLOR(@"#ffffff");
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.contentLabel];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topEqualToView(self.view)
    .heightIs(60);
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(self.titleLabel, 10)
    .heightIs(20);
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .topSpaceToView(self.timeLabel, 0);
}
-(void)xw_loadDataSource{
    
    
    
}

-(void)xw_layoutNavigation{
}
-(void)xw_bindViewModel{
    
}
-(void)setModel:(xw_MsgModel *)model{
    self.title = model.title;
    
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.createTime;
    self.contentLabel.text = model.content;
    [self.contentLabel alignTop];
}
#pragma mark 懒加载

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:@"标题" WithTextColor:COLOR(@"#000000") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:20];

    }
    return _titleLabel;
}
-(UILabel*)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithText:@"时间" WithTextColor:COLOR(@"#eeeeee") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentCenter WithFont:12];

    }
    return _timeLabel;
}
-(UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithText:@"" WithTextColor:COLOR(@"#000000") WithNumOfLine:0 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:17];
        
    }
    return _contentLabel;
}
@end
