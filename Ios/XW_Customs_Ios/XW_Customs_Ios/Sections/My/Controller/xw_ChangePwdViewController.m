//
//  xw_ChangePwdViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2020/5/8.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_ChangePwdViewController.h"
#import "xw_ChangePwdTabCell.h"
#import "xw_MyViewModel.h"
@interface xw_ChangePwdViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) xw_MyViewModel *viewModel;
@end

@implementation xw_ChangePwdViewController

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
   
    
}
-(void)xw_layoutNavigation{
    self.title = @"修改密码";
}
-(void)xw_bindViewModel{
    
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_ChangePwdTabCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([xw_ChangePwdTabCell class])];
    //取消cell点击效果
    [self setupModelOfCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_ChangePwdTabCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void) setupModelOfCell:(UITableViewCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    xw_ChangePwdTabCell* tmCell = (xw_ChangePwdTabCell*)cell;
    
    tmCell.viewMode = self.viewModel;
    tmCell.didChickEventBlock = ^(NSString* params) {
        
        [self changePwdClick];
        
    };
    tmCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)changePwdClick{
    [self.view showLoadingMeg:@"正在重置密码"];

    [[self.viewModel.changePwdCommand execute: nil] subscribeNext:^(NSArray* array) {
        [self.view hideLoading];
        [self.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        [self.view hideLoading];
    }];
    
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[xw_ChangePwdTabCell class] forCellReuseIdentifier:NSStringFromClass([xw_ChangePwdTabCell class])];
    }
    return _tableView;
}
-(xw_MyViewModel*)viewModel{
    if (!_viewModel) {
        _viewModel = [[xw_MyViewModel alloc] init];
    }
    return _viewModel;
}
@end
