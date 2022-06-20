//
//  DelegateRecordViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "DelegateRecordViewController.h"
#import "xw_OfficeViewModel.h"
#import "xw_EntrustModel.h"
#import "xw_EntrustInspectModel.h"
#import "xw_DelegateRecordCell.h"
#import "xw_ScreenViewController.h"
#import "DelegateApplyViewController.h"
#import "DelegateRecordDetailViewController.h"
@interface DelegateRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) xw_HandleQueryModel *queryModel;
@end

@implementation DelegateRecordViewController

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
    self.title = @"委托记录";
    UIButton* screenBtn =[UIButton buttonWithTitie:@"筛选" WithtextColor:COLOR(@"#1F7EFE") WithBackColor:nil WithBackImage: nil WithImage:IMG(@"icon_screen") WithFont:17 EventBlock:^(id  _Nonnull params) {
        GGLog(@"筛选");
        xw_ScreenViewController *vc = [[xw_ScreenViewController alloc] init];
        vc.handleType = @"DELEGATERECORD";
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
    
    [params setObject:entModel.id forKey:@"entrustOrgId"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
    if(self.queryModel != nil){
        [params setObject:self.queryModel.sampleName== nil?@"":self.queryModel.sampleName forKey:@"sampleName"];
        [params setObject:self.queryModel.inspectOrgId== nil?@"":self.queryModel.inspectOrgId forKey:@"inspectOrgId"];
        [params setObject:self.queryModel.from== nil?@"":self.queryModel.from forKey:@"from"];
        [params setObject:self.queryModel.to== nil?@"":self.queryModel.to forKey:@"to"];
        [params setObject:self.queryModel.status== nil?@"":self.queryModel.status forKey:@"status"];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_DelegateRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_DelegateRecordCell"];
    cell.model = self.dataSource[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_EntrustInspectModel* model = self.dataSource[indexPath.section];
    if([model.inspectResult isEqualToString:@"WAIT"]){
        return 220;
    } else {
        return 310;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    xw_EntrustInspectModel* model = self.dataSource[section];
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    
    
    UILabel* stateLabel = [UILabel new];
    
    stateLabel.backgroundColor = COLOR(@"#FA5C45");
    stateLabel.textColor = COLOR(@"#ffffff");
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.font = FONT(14);
    ViewRadius(stateLabel, 5);
    
    [header addSubview:stateLabel];
    stateLabel.sd_layout
    .rightSpaceToView(header, 10)
    .centerYEqualToView(header)
    .widthIs(70).heightIs(30);
    
    UILabel *titleLabel = [UILabel labelWithText:@"委托记录单" WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:17];
    [header addSubview:titleLabel];
    titleLabel.sd_layout
    .leftSpaceToView(header, 10)
    .rightSpaceToView(stateLabel, 10)
    .topEqualToView(header)
    .bottomEqualToView(header);
    
    if([model.status isEqualToString:@"DONE"]){
        stateLabel.backgroundColor = COLOR(@"#4CCD94");
    } else if([model.status isEqualToString:@"ACCEPTED"]){
        stateLabel.backgroundColor = COLOR(@"#FF8800");
    } else {
        stateLabel.backgroundColor = COLOR(@"#FA5C45");
    }
    stateLabel.text = [xw_DataParsingHelper GetDictNameBySubCode:@"ENTRUST_STATUS" subCode:model.status];
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
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    
    UILabel* line = [UILabel new];
    line.backgroundColor = COLOR(@"#EEEEEE");
    [footer addSubview:line];
    line.sd_layout
    .leftEqualToView(footer)
    .rightEqualToView(footer)
    .bottomEqualToView(footer)
    .topEqualToView(footer);
    
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_EntrustInspectModel* model = self.dataSource[indexPath.section];
    if([model.status isEqualToString:@"BACK"]){
        DelegateApplyViewController* vc = [DelegateApplyViewController new];
        vc.model = model;
        vc.type = @"detail";
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        DelegateRecordDetailViewController* vc = [DelegateRecordDetailViewController new];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
        [_tableview registerClass:[xw_DelegateRecordCell class] forCellReuseIdentifier:@"xw_DelegateRecordCell"];
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
