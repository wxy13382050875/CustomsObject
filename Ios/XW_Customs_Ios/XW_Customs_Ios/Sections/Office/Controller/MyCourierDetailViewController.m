//
//  MyCourierDetailViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/8.
//

#import "MyCourierDetailViewController.h"
#import "xw_OfficeViewModel.h"
#import "xw_LogisticsCell.h"
#import "xw_LogisticsModel.h"
@interface MyCourierDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MyCourierDetailViewController

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
    self.title = @"物流信息";
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    [self getData];
}
-(void)xw_loadNewData{
    
    
}
-(void)xw_loadMoreData{
    
//    if ([self.tableview.mj_header isRefreshing]) {
//        return;
//    }
    
}
-(void)getData{
    
    
    [[self.viewModel.expressCommand execute:self.expressId] subscribeNext:^(id  _Nullable x) {
        [self.tableview.mj_header endRefreshing];
        
        xw_LogisticsModel* model = [xw_LogisticsModel mj_objectWithKeyValues:x[@"data"]];;
        self.dataSource = model.result.list;
//        if (array.count < 10) {
//
//            [self.tableview.mj_footer endRefreshingWithNoMoreData];
//        }
//        [self.dataSource addObjectsFromArray:array];
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_LogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_LogisticsCell"];
    cell.row = indexPath.row;
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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
        [_tableview registerClass:[xw_LogisticsCell class] forCellReuseIdentifier:@"xw_LogisticsCell"];
    }
    return _tableview;
}

- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}
//
//
//- (NSMutableArray *)dataSource {
//    if (!_dataSource) {
//        _dataSource = [[NSMutableArray alloc] init];
//    }
//    return _dataSource;
//}
@end
