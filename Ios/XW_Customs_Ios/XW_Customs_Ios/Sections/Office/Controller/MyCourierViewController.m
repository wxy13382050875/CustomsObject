//
//  MyCourierViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "MyCourierViewController.h"
#import "xw_OfficeViewModel.h"
#import "xw_EntrustInspectModel.h"
#import "xw_MyCourierCell.h"
#import "xw_EntrustModel.h"
#
@interface MyCourierViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;

@end

@implementation MyCourierViewController

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
    self.title = @"我的快递";
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
    [params setObject:@"MAIL"forKey:@"takeWay"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_MyCourierCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_MyCourierCell"];
    cell.model = self.dataSource[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    xw_EntrustInspectModel* model = self.dataSource[section];
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *titleLabel = [UILabel labelWithText:[NSString stringWithFormat:@"快递单号:%@",model.expressNo] WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:17];
    [header addSubview:titleLabel];
    titleLabel.sd_layout
    .leftSpaceToView(header, 10)
    .rightSpaceToView(header, 10)
    .topEqualToView(header)
    .bottomEqualToView(header);
    
    UILabel* line = [UILabel new];
    line.backgroundColor = COLOR(@"#EEEEEE");
    [header addSubview:line];
    line.sd_layout
    .leftEqualToView(header)
    .rightEqualToView(header)
    .bottomEqualToView(header)
    .heightIs(1);
    
    return header;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    xw_EntrustInspectModel* model = self.dataSource[section];
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UIButton *btn = [UIButton buttonWithTitie:@"物流信息" WithtextColor:COLOR(@"#206EEA") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
        
        NSString *path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@?expressId=%@",@"MyCourierDetailViewController",model.id];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:path] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
        
    }];
    ViewBorderRadius(btn, 5, 1, COLOR(@"#206EEA"));
    [footer addSubview:btn];
    btn.sd_layout.centerXEqualToView(footer)
    .topSpaceToView(footer, 17)
    .widthIs(150).heightIs(35);
    
    UILabel* line = [UILabel new];
    line.backgroundColor = COLOR(@"#EEEEEE");
    [footer addSubview:line];
    line.sd_layout
    .leftEqualToView(footer)
    .rightEqualToView(footer)
    .bottomEqualToView(footer)
    .heightIs(10);
    
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
        [_tableview registerClass:[xw_MyCourierCell class] forCellReuseIdentifier:@"xw_MyCourierCell"];
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
