//
//  xw_ForgetViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2019/11/27.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_ForgetViewController.h"
#import "xw_ForgetTabCell.h"
#import "xw_LoginViewModel.h"
@interface xw_ForgetViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) xw_LoginViewModel *viewModel;
@end

@implementation xw_ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
-(void)xw_bindViewModel{
//    @weakify(self);
    //将命令执行后的数据交给controller
//    [self.viewModel.resetPwdCommand.executionSignals.switchToLatest subscribeNext:^(id array) {
////        @strongify(self);
//        GGLog(@"测试");
//        [KNotificationCenter postNotificationName:kLoginNotification object:nil];
//    }];
    
    //执行command
    
}
-(void)xw_loadDataSource{
    
}
-(void)xw_layoutNavigation{
    self.title = @"忘记密码";
}
#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_ForgetTabCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([xw_ForgetTabCell class])];
    
    cell.viewMode = self.viewModel;
    cell.didChickEventBlock = ^(NSString* params) {
        if ([params isEqualToString:@"0"]) {
            [self resetPwdClick];
        } else if ([params isEqualToString:@"1"]){
            [self validationClick];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_ForgetTabCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kNavBarAndStatusBarHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[xw_ForgetTabCell class] forCellReuseIdentifier:NSStringFromClass([xw_ForgetTabCell class])];
    }
    return _tableView;
}
-(xw_LoginViewModel*)viewModel{
    if (!_viewModel) {
        _viewModel = [[xw_LoginViewModel alloc] init];
    }
    return _viewModel;
}
-(void)resetPwdClick{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
      if (self.viewModel.phone.length == 11) {
          [params setValue:self.viewModel.phone forKey:@"phone"];
      } else {
          GGLog(@"手机号输入不正确");
          Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"手机号输入不正确").wDisappelSecondSet(1).wStart();
          return ;
      }
      if (self.viewModel.smsCode.length == 6) {
          [params setValue:self.viewModel.smsCode forKey:@"smsCode"];
      } else {
          GGLog(@"验证码输入不正确");
          Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"验证码输入不正确").wDisappelSecondSet(1).wStart();
          return ;
      }
      if (self.viewModel.password.length > 0) {
          [params setValue:self.viewModel.password forKey:@"password"];
      } else {
          GGLog(@"密码输入不正确");
          Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"密码输入不正确").wDisappelSecondSet(1).wStart();
          return ;
      }
    
    [self.view showLoadingMeg:@"正在重置密码"];
    [[self.viewModel.resetPwdCommand execute: params] subscribeNext:^(id x) {
        GGLog(@"发送登录通知");
        [self.view hideLoading];
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        [self.view hideLoading];
    }];
}
-(void)validationClick{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
      if (self.viewModel.phone.length == 11) {
          [params setValue:self.viewModel.phone forKey:@"phone"];
      } else {
          GGLog(@"手机号输入不正确");
          Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"手机号输入不正确").wDisappelSecondSet(1).wStart();
          return ;
      }
    [self.view showLoadingMeg:@"发送验证码"];
    [[self.viewModel.validationCommand execute: params] subscribeNext:^(id x) {
        [self.view hideLoading];
        GGLog(@"发送登录通知");
        
    } error:^(NSError *error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        [self.view hideLoading];
    }];
}
@end
