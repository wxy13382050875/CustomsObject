//
//  CertificateManageViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "CertificateManageViewController.h"
#import "xw_CertificateCell.h"
#import "xw_OfficeViewModel.h"
#import "xw_EntrustModel.h"
#import "xw_EntrustInspectModel.h"
#import "xw_ScreenViewController.h"
#import "xw_HandleQueryModel.h"
#import "CertificateQueryViewController.h"
@interface CertificateManageViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) xw_HandleQueryModel *queryModel;
@end

@implementation CertificateManageViewController

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
    self.title = @"证书管理";
    UIButton* screenBtn =[UIButton buttonWithTitie:@"筛选" WithtextColor:COLOR(@"#1F7EFE") WithBackColor:nil WithBackImage: nil WithImage:IMG(@"icon_screen") WithFont:17 EventBlock:^(id  _Nonnull params) {
        GGLog(@"筛选");
        xw_ScreenViewController *vc = [[xw_ScreenViewController alloc] init];
        vc.handleType = @"CERTIFICATE";
        vc.refreshBlock = ^(xw_HandleQueryModel * _Nonnull model) {
            self.queryModel = model;
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
        conf.direction = CWDrawerTransitionFromRight;
//        conf.showAnimDuration = 1.0f;
        
        [self cw_showDrawerViewController:vc animationType:CWDrawerAnimationTypeMask configuration:conf];
    }];
    [screenBtn layoutWithStatus:XWLayoutStatusNormal andMargin:5];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:screenBtn];
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    kSetMJRefresh(self.tableview);
}
-(void)xw_loadNewData{
    [self.dataSource removeAllObjects];
    self.page = 1;
    [self getData];
    
}
-(void)xw_loadMoreData{
    
    if ([self.tableview.mj_header isRefreshing]) {
        return;
    }
    self.page ++;
    [self getData];
}
-(void)getData{
    
    xw_EntrustModel * entModel = [xw_EntrustModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].entrustOrg];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:@"DONE" forKey:@"status"];
    [params setObject:entModel.id forKey:@"entrustOrgId"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
    if(self.queryModel != nil){
        [params setObject:self.queryModel.sn== nil?@"":self.queryModel.sn forKey:@"sn"];
        [params setObject:self.queryModel.sampleName== nil?@"":self.queryModel.sampleName forKey:@"sampleName"];
        [params setObject:self.queryModel.from== nil?@"":self.queryModel.from forKey:@"from"];
        [params setObject:self.queryModel.to== nil?@"":self.queryModel.to forKey:@"to"];
    }
    [[self.viewModel.getInspectCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self.tableview.mj_header endRefreshing];
        
        NSArray* array = [xw_EntrustInspectModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"content"]];
        if (array.count < 10) {
            
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        [self.dataSource addObjectsFromArray:array];
        [self.tableview reloadData];
        
    } error:^(NSError * _Nullable error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
        [self.tableview.mj_header endRefreshing];
    }];
}
-(void)xw_setupUI{
    [self.view addSubview:self.tableview];
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, 0, 0)) ;
}
#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_CertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_CertificateCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CertificateQueryViewController* vc = [CertificateQueryViewController new];
    vc.strModel = [self.dataSource[indexPath.row] mj_JSONString] ;
    [self.navigationController pushViewController:vc animated:YES];
    
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
        [_tableview registerClass:[xw_CertificateCell class] forCellReuseIdentifier:@"xw_CertificateCell"];
    }
    return _tableview;
}



- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
