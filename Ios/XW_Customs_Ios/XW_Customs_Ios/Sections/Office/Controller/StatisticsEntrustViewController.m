//
//  StatisticsEntrustViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/2.
//

#import "StatisticsEntrustViewController.h"
#import "xw_OfficeViewModel.h"
#import "xw_StatisticsEntrustCell.h"
#import "xw_StatisticsEntrustModel.h"
@interface StatisticsEntrustViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;
@end

@implementation StatisticsEntrustViewController

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
-(void)xw_bindViewModel{
    self.title = @"委托单位委托统计";
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
 
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:@"" forKey:@"entrustOrgId"];
    [[self.viewModel.entrustStatiCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self.tableview.mj_header endRefreshing];
        
        NSArray* array = [xw_StatisticsEntrustModel mj_objectArrayWithKeyValuesArray:x[@"data"]];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_StatisticsEntrustCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_StatisticsEntrustCell"];
    cell.model = self.dataSource [indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    footer.backgroundColor =COLOR(@"#eeeeee");
    
    return footer;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
        [_tableview registerClass:[xw_StatisticsEntrustCell class] forCellReuseIdentifier:@"xw_StatisticsEntrustCell"];
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
