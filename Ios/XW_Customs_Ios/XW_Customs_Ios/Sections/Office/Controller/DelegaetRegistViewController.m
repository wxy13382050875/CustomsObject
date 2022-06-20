//
//  DelegaetRegistViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "DelegaetRegistViewController.h"
#import "xw_DelegaetRegistCell.h"
#import "xw_EntrustModel.h"
#import "xw_OfficeViewModel.h"
@interface DelegaetRegistViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property(nonatomic,strong)xw_EntrustModel* model;
@property(nonatomic,strong)UIButton* confirmBtn;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@end

@implementation DelegaetRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    self.title = @"委托单位登记";
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    [self getData];
}
-(void)xw_loadNewData{
    
    
}
-(void)xw_loadMoreData{
//    if ([self.collectionView.mj_header isRefreshing]) {
//        return;
//    }
//    [self getData];
}
-(void)getData{

    self.model = [xw_EntrustModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].entrustOrg];
    if(self.model != nil){
        self.model.typeName = [xw_DataParsingHelper GetDictNameBySubCode:@"ENTRUST_ORG_TYPE" subCode:self.model.type];
        [self.tableview reloadData];
    }
    
}
-(void)xw_setupUI{
    [self.view addSubview:self.tableview];
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, 0, 0)) ;
    
    [self.view addSubview:self.confirmBtn];
    self.confirmBtn.sd_layout
    .leftSpaceToView(self.view, 20)
    .rightSpaceToView(self.view, 20)
    .bottomSpaceToView(self.view, kBottomSafeHeight + 20)
    .heightIs(50);
    
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_DelegaetRegistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_DelegaetRegistCell"];
   
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_DelegaetRegistCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
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
        [_tableview registerClass:[xw_DelegaetRegistCell class] forCellReuseIdentifier:@"xw_DelegaetRegistCell"];
    }
    return _tableview;
}

-(UIButton*)confirmBtn{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithTitie:@"确认" WithtextColor:COLOR(@"#FFFFFF") WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            NSLog(@"确认%@",self.model.mj_JSONString);
            [self submitInfo];
        }];
        ViewRadius(_confirmBtn, 5);
    }
    return _confirmBtn;
}
-(void)submitInfo{
    if(self.model.name == nil || [self.model.name isEqualToString:@""]){
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"单位名称不能为空！").wDisappelSecondSet(1).wStart();
        return;
    }
    if(self.model.address == nil || [self.model.address isEqualToString:@""]){
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"地址不能为空！").wDisappelSecondSet(1).wStart();
        return;
    }
    if(self.model.contacts == nil || [self.model.contacts isEqualToString:@""]){
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"联系人不能为空！").wDisappelSecondSet(1).wStart();
        return;
    }
    if(self.model.phone == nil || [self.model.phone isEqualToString:@""]){
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"电话不能为空！").wDisappelSecondSet(1).wStart();
        return;
    }
 
    [self.view showLoadingMeg:@"正在提交"];
    if (self.model.id != nil) {
        
        [[self.viewModel.putEntrustOrgCommand execute:[self.model mj_JSONObject]] subscribeNext:^(id  _Nullable x) {
            [self.view hideLoading];

            xw_EntrustModel * entModel = [xw_EntrustModel mj_objectWithKeyValues:x[@"data"]];
            [xw_ConfigHelper sharedInstance].entrustOrg = entModel.mj_JSONString;
            [self.navigationController popViewControllerAnimated:YES];

        } error:^(NSError * _Nullable error) {
            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
            [self.view hideLoading];
        }];
    } else {
        [[self.viewModel.postEntrustOrgCommand execute:[self.model mj_JSONObject]] subscribeNext:^(id  _Nullable x) {
            [self.view hideLoading];

            xw_EntrustModel * entModel = [xw_EntrustModel mj_objectWithKeyValues:x[@"data"]];
            [xw_ConfigHelper sharedInstance].entrustOrg = entModel.mj_JSONString;
            [self.navigationController popViewControllerAnimated:YES];

        } error:^(NSError * _Nullable error) {
            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
            [self.view hideLoading];
        }];
    }
}
- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}
- (xw_EntrustModel *)model {
    if (!_model) {
        _model = [[xw_EntrustModel alloc] init];
    }
    return _model;
}

@end
