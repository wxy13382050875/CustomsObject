//
//  xw_RegisterViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2019/11/27.
//  Copyright © 2019 武新义. All rights reserved.
//

#import "xw_RegisterViewController.h"
#import "xw_RegisterTabCell.h"
#import "xw_LoginViewModel.h"
#import "xw_FaceAuthViewModel.h"
#import "xw_WebViewController.h"
@interface xw_RegisterViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) xw_LoginViewModel *viewModel;
@property (nonatomic, strong) xw_FaceAuthViewModel *faceViewModel;
@end

@implementation xw_RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(void)xw_layoutNavigation{
    self.title = @"注册";
}
-(void)xw_bindViewModel{
   
//    [self.viewModel.validationCommand.executionSignals.switchToLatest subscribeNext:^(id reqoneObj) {
//
//        [self.view hideLoading];
//
//
//    } error:^(NSError *error) {
//        NSLog(@"----error----%@",error);
//        [self.view hideLoading];
//    }];
//
//    [self.faceViewModel.getFaceStatusCommand.executionSignals.switchToLatest subscribeNext:^(id reqoneObj) {
//
//        [self.view hideLoading];
//        [self getFaceToken];
//
//    } error:^(NSError *error) {
//        NSLog(@"----error----%@",error);
//        [self.view hideLoading];
//    }];
//    [self.faceViewModel.getFaceTokenCommand.executionSignals.switchToLatest subscribeNext:^(id reqoneObj) {
//
//            [self.view hideLoading];
//            [self transferRPSDK:reqoneObj[@"data"]];
//
//    } error:^(NSError *error) {
//        NSLog(@"----error----%@",error);
//        [self.view hideLoading];
//
//    }];
//    [self.faceViewModel.getVerifyResultCommand.executionSignals.switchToLatest subscribeNext:^(id reqoneObj) {
//        [self.view hideLoading];
//    //            [self transferRPSDK:];
////        GGLog(@"verifyStatus = %@ ",reqoneObj[@"data"][@"verifyStatus"] );
//        if ([reqoneObj[@"data"][@"verifyStatus"] integerValue] == 1) {
////            GGLog(@"idCardNumber = %@ ",reqoneObj[@"data"][@"material"][@"idCardNumber"] );
////             GGLog(@"self.viewModel.idCode = %@ ",self.viewModel.idCode );
//            if ([self.viewModel.idCode isEqualToString:reqoneObj[@"data"][@"material"][@"idCardNumber"] ]) {
////                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"认证成功").wDisappelSecondSet(1).wStart();
//                [self registerClick];
//            } else {
//                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"填写的身份证，和实人认证身份证不一致！").wDisappelSecondSet(1).wStart();
//
//            }
//        } else {
//            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"认证失败").wDisappelSecondSet(1).wStart();
//        }
//
//
//
//    } error:^(NSError *error) {
//        NSLog(@"----error----%@",error);
//        [self.view hideLoading];
//    }];
//    [self.viewModel.registerCommand.executionSignals.switchToLatest subscribeNext:^(id array) {
//        [self.view hideLoading];
//        [self.navigationController popViewControllerAnimated:YES];
//    } error:^(NSError *error) {
//        NSLog(@"----error----%@",error);
//        [self.view hideLoading];
//    }];
}
-(void)xw_loadDataSource{
    
}
#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_RegisterTabCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([xw_RegisterTabCell class])];
    
    cell.viewMode = self.viewModel;
    cell.didChickEventBlock = ^(NSString* params) {

        if ([params isEqualToString:@"0"]) {
            [self registerClick];

        } else if([params isEqualToString:@"1"]){
            [self validationClick];
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
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_RegisterTabCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
    }];
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return kNavBarAndStatusBarHeight;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}
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
        [_tableView registerClass:[xw_RegisterTabCell class] forCellReuseIdentifier:NSStringFromClass([xw_RegisterTabCell class])];
    }
    return _tableView;
}
-(xw_LoginViewModel*)viewModel{
    if (!_viewModel) {
        _viewModel = [[xw_LoginViewModel alloc] init];
    }
    return _viewModel;
}
//-(xw_FaceAuthViewModel*)faceViewModel{
//    if (!_faceViewModel) {
//        _faceViewModel = [[xw_FaceAuthViewModel alloc] init];
//        _faceViewModel.bizType = @"realPersonAuth";
//    }
//    return _faceViewModel;
//}
//-(void)getFaceStatus{
//    @weakify(self)
//    [self.view showLoadingMeg:@"正在验证"];
//    [self.faceViewModel.getFaceStatusCommand execute: nil];
//
//}
-(void)registerClick{
    
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
    
    
    [self.view showLoadingMeg:@"正在注册"];
//    [self.viewModel.registerCommand execute: nil];
    [[self.viewModel.registerCommand execute: params] subscribeNext:^(NSArray* array) {
        [self.view hideLoading];
        GGLog(@"测试");
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"注册成功").wDisappelSecondSet(1).wStart();
//        [self.navigationController popViewControllerAnimated:YES];
        [self loginClick];
        
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
    [[self.viewModel.validationCommand execute: params] subscribeNext:^(NSArray* array) {
        [self.view hideLoading];
        GGLog(@"测试");
        
    } error:^(NSError *error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        [self.view hideLoading];
    }];
}
-(void)loginClick{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setValue:self.viewModel.phone forKey:@"phone"];
    [params setValue:self.viewModel.password forKey:@"password"];
    
    [self.view showLoadingMeg:@"正在登陆"];
    [[self.viewModel.loginCommand execute: params] subscribeNext:^(NSArray* array) {
        [self.view hideLoading];
        GGLog(@"测试");
        
        NSDictionary* account = @{
            @"account":self.viewModel.phone,
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
        
        
        if ([xw_ConfigHelper sharedInstance].isUMPush) {
            [self bindDeviceToken];
        } else {
            [KNotificationCenter postNotificationName:kLoginNotification object:nil];
        }
        
    } error:^(NSError *error) {
        [self.view hideLoading];
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
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
