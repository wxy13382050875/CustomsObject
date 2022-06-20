//
//  StatisticsQueryViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/2.
//

#import "StatisticsQueryViewController.h"
#import "xw_CeneralListCell.h"

@interface StatisticsQueryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation StatisticsQueryViewController

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
    self.title = @"查询统计";
//    self.title = @"采样记录";
//    self.title = @"检测结果登记";
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    self.dataSource = @[@"受理情况统计",@"委托单位委托统计"];
    [self.tableview reloadData];
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
//    [[self.viewModel.msgGroupCommand execute:@{}] subscribeNext:^(id  _Nullable x) {
//        self.dataSource = [xw_MsgGroupModel mj_objectArrayWithKeyValuesArray:x[@"data"]];
//        [self.tableview reloadData];
//
//    } error:^(NSError * _Nullable error) {
//
//    }];
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
    xw_CeneralListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_CeneralListCell"];
    cell.title = self.dataSource [indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    footer.backgroundColor =COLOR(@"#eeeeee");
    
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* iosPath ;
    if(indexPath.section == 0){
        iosPath = @"StatisticsAcceptViewController";
    } else {
        iosPath = @"StatisticsEntrustViewController";
    }
    NSString *path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@",iosPath];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:path] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableview.estimatedRowHeight = 0;
            _tableview.estimatedSectionFooterHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableview registerClass:[xw_CeneralListCell class] forCellReuseIdentifier:@"xw_CeneralListCell"];
    }
    return _tableview;
}


@end
