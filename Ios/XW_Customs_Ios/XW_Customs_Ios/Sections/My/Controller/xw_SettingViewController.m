//
//  xw_SettingViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2020/5/8.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_SettingViewController.h"
#import "xw_CeneralListCell.h"
@interface xw_SettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation xw_SettingViewController

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
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0)) ;
}
-(void)xw_loadDataSource{
   

    self.dataSource = @[@"修改账户密码"];
    [self.tableView reloadData];
}
-(void)xw_layoutNavigation{
    self.title = @"设置";
}
-(void)xw_bindViewModel{
    
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_CeneralListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([xw_CeneralListCell class])];
    //取消cell点击效果
    cell.title = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
 
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    footer.backgroundColor = COLOR(@"#eeeeee");
    UIButton* logoutBtn = [UIButton buttonWithTitie:@"退出登录" WithtextColor:COLOR(@"#000000") WithBackColor:COLOR(@"#ffffff") WithBackImage:nil WithImage:nil WithFont:16 EventBlock:^(id  _Nonnull params) {
  
        [xw_ConfigHelper sharedInstance].isLogin = false;
        [KNotificationCenter postNotificationName:kLogoutNotification object:nil];
        
    }];
    [footer addSubview:logoutBtn];
    logoutBtn.sd_layout
    .leftEqualToView(footer)
    .rightEqualToView(footer)
    .bottomEqualToView(footer)
    .topSpaceToView(footer, 10);
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.row== 0){
        [self skipChangePwdViewController];
    }
    
}



-(void)skipChangePwdViewController{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"XWMVVMRACRouter://NaviPush/xw_ChangePwdViewController"] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = COLOR(@"#eeeeee");
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[xw_CeneralListCell class] forCellReuseIdentifier:NSStringFromClass([xw_CeneralListCell class])];
    }
    return _tableView;
}

@end
