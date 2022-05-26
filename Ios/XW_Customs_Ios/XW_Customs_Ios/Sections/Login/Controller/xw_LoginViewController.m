//
//  xw_LoginViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2019/11/27.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_LoginViewController.h"
#import "xw_LoginTabCell.h"
#import "xw_LoginViewModel.h"
#import "xw_WebViewController.h"
#import "xw_ForgetViewController.h"
@interface xw_LoginViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) xw_LoginViewModel *viewModel;
@end

@implementation xw_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
//    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id array) {
////        @strongify(self);
//        [self.view hideLoading];
//        GGLog(@"测试");
//        [KNotificationCenter postNotificationName:kLoginNotification object:nil];
//    }];
    
    //执行command
    
}
-(void)xw_layoutNavigation{
    
}
-(void)xw_loadDataSource{
    
}
#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_LoginTabCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([xw_LoginTabCell class])];
    
    cell.viewMode = self.viewModel;
    cell.didChickEventBlock = ^(NSString* params) {
        
        if ([params isEqualToString:@"0"]) {
            [self loginClick];
        } else if([params isEqualToString:@"agreement"]){
            xw_WebViewController* viewController = [xw_WebViewController new];

            viewController.contentId = @"7";
            viewController.type = @"noAuth";
            [self.navigationController pushViewController:viewController animated:YES];
        } else if([params isEqualToString:@"privacy"]){
            xw_WebViewController* viewController = [xw_WebViewController new];

            viewController.contentId = @"2";
            viewController.type = @"noAuth";
            [self.navigationController pushViewController:viewController animated:YES];
        } else if([params isEqualToString:@"visitor"]){
            
        } else {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:params] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
        }
        
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_LoginTabCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
    }];
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
        [_tableView registerClass:[xw_LoginTabCell class] forCellReuseIdentifier:NSStringFromClass([xw_LoginTabCell class])];
    }
    return _tableView;
}
-(xw_LoginViewModel*)viewModel{
    if (!_viewModel) {
        _viewModel = [[xw_LoginViewModel alloc] init];
    }
    return _viewModel;
}
-(void)loginClick{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    if (self.viewModel.account.length == 11) {
        [params setValue:self.viewModel.account forKey:@"phone"];
    } else {
        GGLog(@"手机号输入不正确");
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"手机号输入不正确").wDisappelSecondSet(1).wStart();
        self.viewModel.account = @"";
        return ;
    }
    if (self.viewModel.password.length > 0) {
        [params setValue:self.viewModel.password forKey:@"password"];
    } else {
        GGLog(@"密码输入不正确");
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"密码输入不正确").wDisappelSecondSet(1).wStart();
        self.viewModel.password = @"";
        return ;
    }
    [self.view showLoadingMeg:@"正在登陆"];
    [[self.viewModel.loginCommand execute: params] subscribeNext:^(NSDictionary* dict) {
        [self.view hideLoading];
        GGLog(@"测试");
        
        NSDictionary* account = @{
            @"account":self.viewModel.account,
            @"pwd":self.viewModel.password
            
        };
        
        NSMutableArray *arr  = [[NSUserDefaults standardUserDefaults] objectForKey:@"accountInfo"];
        
        if (arr == nil) {
            arr = [[NSMutableArray alloc] init];
        }
        NSMutableArray *newArray = [NSMutableArray arrayWithArray:arr];
        if ([newArray count] == 0 ) {
            [newArray addObject:account];
        } else {
            BOOL isSame = NO;
            for (int i = 0; i < [arr count]; i++) {
                NSDictionary * dict = arr[i];
                if ([dict[@"account"] isEqual:self.viewModel.account] ) {
                    isSame = YES;
                    [newArray replaceObjectAtIndex:i withObject:account];
                }
            }
            if (!isSame) {
                [newArray addObject:account];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"accountInfo"];

        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSLog(@"%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"accountInfo"] mj_JSONString]);
        
        if ([xw_ConfigHelper sharedInstance].isUMPush) {
            [self bindDeviceToken];
        } else {
            [KNotificationCenter postNotificationName:kLoginNotification object:nil];
        }
        
//         [KNotificationCenter postNotificationName:kLoginNotification object:nil];
    } error:^(NSError *error) {
        [self.view hideLoading];
        
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        NSLog(@"code %ld",error.code);
        if (error.code == 1023) {
            xw_ForgetViewController* viewController = [xw_ForgetViewController new];

            [self.navigationController pushViewController:viewController animated:YES];
            
        }
    }];
    
}
-(void)bindDeviceToken{
    [[self.viewModel.bindDeviceTokenCommand execute: nil] subscribeNext:^(id x) {
        [self.view hideLoading];
        [KNotificationCenter postNotificationName:kLoginNotification object:nil];
       
    } error:^(NSError *error) {
        [self.view hideLoading];
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        [xw_ConfigHelper sharedInstance].sUserInfo = @"";
    }];
}
@end
