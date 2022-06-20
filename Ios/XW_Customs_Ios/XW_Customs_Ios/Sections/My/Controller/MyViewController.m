//
//  MyViewController.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "MyViewController.h"
#import "xw_CeneralListCell.h"
#import "xw_UserInfoModel.h"
@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray* dataSource;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar xw_setBackgroundColor:COLOR(@"#206EEA")];
   
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar xw_setBackgroundColor:COLOR(@"##ffffff")];
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
    self.title = @"我的";
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    self.dataSource = @[@"设置"];
    [self.tableview reloadData];
}
-(void)xw_loadNewData{
    
//    [self getData];
}
-(void)xw_loadMoreData{
//    if ([self.collectionView.mj_header isRefreshing]) {
//        return;
//    }
//    [self getData];
}
-(void)getData{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            /// 下拉时候一定要停止当前播放，不然有新数据，播放位置会错位。
////            self.viewModel.page = [NSString stringWithFormat:@"%ld",self.page];
////            self.viewModel.size = @"10";
//            [[self.viewModel.requestCommand execute: nil] subscribeNext:^(id x) {
//                GGLog(@"刷新");
//                [self.collectionView.mj_header endRefreshing];
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//                self.model = [xw_InfoModel mj_objectWithKeyValues:x[@"data"]];
//
//                [self.collectionView reloadData];
//
//            } error:^(NSError *error) {
//                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
//                [self.collectionView.mj_header endRefreshing];
//                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//            }];
//    //
//        });
}
-(void)xw_setupUI{
//    self.view.backgroundColor = COLOR(@"#eeeeee");
    [self.view addSubview:self.tableview];
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0)) ;
}

#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_CeneralListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_CeneralListCell"];
    cell.title = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"XWMVVMRACRouter://NaviPush/xw_SettingViewController"] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 147;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    xw_UserInfoModel* model =  [xw_UserInfoModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].sUserInfo];
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 147)];
    headerView.backgroundColor = COLOR(@"#206EEA");
    
    UIImageView* portraitImage = [UIImageView new];
    portraitImage.image = IMG(@"icon_user");
    [headerView addSubview:portraitImage];
    portraitImage.sd_layout
    .leftSpaceToView(headerView, 15)
    .centerYEqualToView(headerView)
    .widthIs(50).heightIs(50);
    
    
    
    
    UIView* bgview = [UIView new];
    
    [headerView addSubview:bgview];
    bgview.sd_layout
    .rightSpaceToView(headerView, 10)
    .leftSpaceToView(portraitImage, 10)
    .centerYEqualToView(portraitImage)
    .heightIs(50);
    
    UILabel* phoneLabel = [UILabel new];
    phoneLabel.text = model.phone;
    phoneLabel.font = FONT(13);
    phoneLabel.textColor = COLOR(@"#ffffff");
    [bgview addSubview:phoneLabel];
    
    phoneLabel.sd_layout
    .leftEqualToView(bgview)
    .rightEqualToView(bgview)
    .topEqualToView(bgview)
    .heightIs(30);
    
    UILabel* titleLabel = [UILabel new];
    titleLabel.text = model.trueName==nil ? @"请完善信息" : model.trueName;
    titleLabel.font = FONT(16);
    titleLabel.textColor = COLOR(@"#ffffff");
    [bgview addSubview:titleLabel];
 
    titleLabel.sd_layout
    .leftEqualToView(bgview)
    .topSpaceToView(phoneLabel, 0)
    .bottomEqualToView(bgview)
    .widthIs(200);
    
    
    
    
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor whiteColor];
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
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
