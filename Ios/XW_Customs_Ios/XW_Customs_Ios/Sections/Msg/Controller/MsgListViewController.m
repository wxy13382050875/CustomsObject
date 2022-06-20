//
//  MsgListViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/7.
//

#import "MsgListViewController.h"
#import "xw_MsgViewModel.h"
#import "xw_MsgCell.h"
#import "xw_MsgModel.h"
#import "MsgDetailViewController.h"
@interface MsgListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_MsgViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic,assign)NSInteger page;
@end

@implementation MsgListViewController

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
    self.title = [xw_DataParsingHelper GetDictNameBySubCode:@"MESSAGE_TYPE" subCode:self.type];
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    [self getData];
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
    [params setObject:self.type forKey:@"type"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
    [params setObject:[xw_ConfigHelper sharedInstance].userId forKey:@"targetUserId"];
    [[self.viewModel.msgListCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self.tableview.mj_header endRefreshing];
        
        NSArray* array = [xw_MsgModel mj_objectArrayWithKeyValuesArray:x[@"data"][@"content"]];
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
    xw_MsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_MsgCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self handleClick:self.dataSource[indexPath.row]];
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
        [_tableview registerClass:[xw_MsgCell class] forCellReuseIdentifier:@"xw_MsgCell"];
    }
    return _tableview;
}



- (xw_MsgViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_MsgViewModel alloc] init];
    }
    return _viewModel;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
-(void)handleClick:(xw_MsgModel*)model{
    [[self.viewModel.msgClickCommand execute:model.id] subscribeNext:^(id  _Nullable x) {
        
        model.readFlag = true;
        [self.tableview reloadData];
        MsgDetailViewController* controller = [MsgDetailViewController new];
        controller.model = model;
        [self.navigationController pushViewController:controller animated:YES];
    } error:^(NSError * _Nullable error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
    }];
}
@end
