//
//  MsgViewController.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "MsgViewController.h"
#import "xw_MsgGroupCell.h"
#import "xw_MsgViewModel.h"
#import "xw_MsgGroupModel.h"
#import "MsgListViewController.h"
@interface MsgViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property(nonatomic,strong)xw_MsgViewModel* viewModel;
@property(nonatomic,strong)NSArray* dataSource;
@end

@implementation MsgViewController

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
    self.title = @"消息";
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
    [[self.viewModel.msgGroupCommand execute:@{}] subscribeNext:^(id  _Nullable x) {
        self.dataSource = [xw_MsgGroupModel mj_objectArrayWithKeyValuesArray:x[@"data"]];
        [self.tableview reloadData];
        
    } error:^(NSError * _Nullable error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
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
    xw_MsgGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_MsgGroupCell"];
    cell.model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    xw_MsgGroupModel* model = self.dataSource[indexPath.row];
    MsgListViewController* controller = [MsgListViewController new];
    controller.type = model.type;
    [self.navigationController pushViewController:controller animated:YES];
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
        [_tableview registerClass:[xw_MsgGroupCell class] forCellReuseIdentifier:@"xw_MsgGroupCell"];
    }
    return _tableview;
}
-(xw_MsgViewModel*)viewModel{
    if (!_viewModel) {
        _viewModel = [[xw_MsgViewModel alloc] init];
    }
    return _viewModel;
}


@end
