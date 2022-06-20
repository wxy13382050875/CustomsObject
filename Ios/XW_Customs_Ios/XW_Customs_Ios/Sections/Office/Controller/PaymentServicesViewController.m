//
//  PaymentServicesViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "PaymentServicesViewController.h"
#import "xw_PaymentServicesCell.h"
#import "xw_OfficeViewModel.h"
@interface PaymentServicesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;

@property (nonatomic, strong) NSString *qrCode;
@end

@implementation PaymentServicesViewController

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
    self.title = @"缴费服务";
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
    [[self.viewModel.getQrCodeCommand execute:@"125"] subscribeNext:^(id  _Nullable x) {
//        self.dataSource = [xw_MsgGroupModel mj_objectArrayWithKeyValuesArray:x[@"data"]];
        self.qrCode = [NSString stringWithFormat:@"data:image/png;base64,%@",x[@"data"]];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_PaymentServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_PaymentServicesCell"];
    cell.qrCode = self.qrCode;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_PaymentServicesCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
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
        [_tableview registerClass:[xw_PaymentServicesCell class] forCellReuseIdentifier:@"xw_PaymentServicesCell"];
    }
    return _tableview;
}

- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}

@end
