//
//  DelegateHandleTabDetailViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "DelegateHandleTabDetailViewController.h"
#import "xw_HandleTabDetailCell.h"
#import "xw_OfficeViewModel.h"
@interface DelegateHandleTabDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@end

@implementation DelegateHandleTabDetailViewController

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
-(void)xw_layoutNavigation{
    if([self.type isEqualToString:@"DISPATCH"]){
        self.title = @"派单";
    } else {
        self.title = @"委托受理";
    }
    
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    if(self.model != nil){
        [self.tableview reloadData];
    }
}
-(void)xw_loadNewData{
    
    
}
-(void)xw_loadMoreData{
//    if ([self.collectionView.mj_header isRefreshing]) {
//        return;
//    }
//    [self getData];
}

-(void)xw_setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    
    self.btn1.sd_layout
    .leftSpaceToView(self.view, 20)
    .bottomSpaceToView(self.view, kBottomSafeHeight)
    .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
    
    self.btn2.sd_layout
    .rightSpaceToView(self.view, 20)
    .bottomSpaceToView(self.view, kBottomSafeHeight)
    .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
    if([self.type isEqualToString:@"DISPATCH"]){
        
        [self.btn1 setTitle:@"取消" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"派单" forState:UIControlStateNormal];
    } else {
        [self.btn1 setTitle:@"退回" forState:UIControlStateNormal];
        [self.btn2 setTitle:@"受理" forState:UIControlStateNormal];
    }
    
    
    
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, kBottomSafeHeight + 50, 0)) ;
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_HandleTabDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_HandleTabDetailCell"];
    cell.type = self.type;
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_HandleTabDetailCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
        // configurations
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableview.estimatedRowHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableview registerClass:[xw_HandleTabDetailCell class] forCellReuseIdentifier:@"xw_HandleTabDetailCell"];
    }
    return _tableview;
}
-(UIButton*)btn1{
    if(!_btn1){
        _btn1 = [UIButton buttonWithTitie:@"" WithtextColor:COLOR(@"#206EEA") WithBackColor:COLOR(@"#D8E7FF") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            if([self.type isEqualToString:@"DISPATCH"]){
                NSLog(@"取消");
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                NSLog(@"退回");
                [self postEntrustInspect:@"BACK"];
            }
        }];
        ViewRadius(_btn1, 5);
    }
    return _btn1;
}
-(UIButton*)btn2{
    if(!_btn2){
        _btn2 = [UIButton buttonWithTitie:@"" WithtextColor:COLOR(@"#FFFFFF") WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            if([self.type isEqualToString:@"DISPATCH"]){
                NSLog(@"派单");
                [self postEntrustInspect:@"DISPATCH"];
            } else {
                NSLog(@"受理");
                [self postEntrustInspect:@"ACCEPT"];
            }
          
        }];
        ViewRadius(_btn2, 5);
    }
    return _btn2;
}
-(void) postEntrustInspect:(NSString*)subType{
    if(![subType isEqualToString:@"BACK"]){
        if(self.model.sn == nil || [self.model.sn isEqualToString:@""]){
            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"检测编号不能为空！").wDisappelSecondSet(1).wStart();
            return;
        }
        if(self.model.busCategory == nil || [self.model.busCategory isEqualToString:@""]){
            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"业务类别不能为空！").wDisappelSecondSet(1).wStart();
            return;
        }
        if(self.model.inspectOrgId == nil || [self.model.inspectOrgId isEqualToString:@""]){
            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"检测机构不能为空！").wDisappelSecondSet(1).wStart();
            return;
        }
    }
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.model.id forKey:@"id"];
    [params setObject:subType forKey:@"subType"];
    [params setObject:self.model.sn forKey:@"sn"];
    [params setObject:self.model.inspectOrgId forKey:@"inspectOrgId"];
    [params setObject:self.model.busCategory forKey:@"busCategory"];
    [params setObject:self.model.excStandard forKey:@"excStandard"];
    [params setObject:self.model.project forKey:@"project"];
    [params setObject:self.model.projectBasis forKey:@"projectBasis"];
    if([subType isEqualToString:@"DISPATCH"]){
        [params setObject:self.model.inspectOrgId forKey:@"source"];
    }
    
    [self.view showLoadingMeg:@"正在提交"];
    [[self.viewModel.postEntrustInspectCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self.view hideLoading];
        [KNotificationCenter postNotificationName:kRefreshNotification object:nil userInfo:@{@"state":@""}];
        [self.navigationController popViewControllerAnimated:YES];

    } error:^(NSError * _Nullable error) {
        [self.view hideLoading];
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();

    }];
}
- (xw_EntrustInspectModel *)model {
    if (!_model) {
        _model = [[xw_EntrustInspectModel alloc] init];
    }
    return _model;
}
- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}

@end
