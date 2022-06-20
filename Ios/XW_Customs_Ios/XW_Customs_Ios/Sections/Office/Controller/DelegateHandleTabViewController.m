//
//  DelegateHandleTabViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/9.
//

#import "DelegateHandleTabViewController.h"
#import "xw_EntrustInspectModel.h"
#import "xw_OfficeViewModel.h"
#import "xw_DelegateHandleCell.h"
#import "DelegateHandleTabDetailViewController.h"
#import "SamplingDetailViewController.h"
#import "ResultsDetailViewController.h"
#import "CertQrViewController.h"
#import "MyCourierDetailViewController.h"
@interface DelegateHandleTabViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL isDataLoaded;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;
@property (nonatomic, strong) xw_HandleQueryModel *queryModel;
@end

@implementation DelegateHandleTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)xw_layoutNavigation{
    self.title = @"未受理";
}
-(void)xw_bindViewModel{
    RegisterNotice(kRefreshNotification, @selector(refreshData:));
}
-(void)refreshData:(NSNotification*)notific{
    NSLog(@"11111");
    NSString* state = notific.userInfo[@"state"];
    if([state isEqualToString:self.queryStatus]){
        self.queryModel = notific.userInfo[@"model"];
    }
    [self xw_loadNewData];
}
-(void)xw_loadDataSource{
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
    
    [params setObject:self.queryStatus forKey:@"queryInspectStatus"];
    [params setObject:[xw_ConfigHelper sharedInstance].orgsId forKey:@"inspectOrgId"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.page] forKey:@"page"];
    [params setObject:@"10" forKey:@"size"];
    if(self.queryModel != nil){
        if([self.queryStatus isEqualToString:@"WAIT_ACCEPT"]||
           [self.queryStatus isEqualToString:@"ACCEPTED"]){
            [params setObject:self.queryModel.sn== nil?@"":self.queryModel.sn forKey:@"sn"];
            [params setObject:self.queryModel.inspectOrgId== nil?@"":self.queryModel.inspectOrgId forKey:@"inspectOrgId"];
            [params setObject:self.queryModel.acceptTimeTo== nil?@"":self.queryModel.acceptTimeTo forKey:@"acceptTimeTo"];
            
        } else if([self.queryStatus isEqualToString:@"WAIT_SAMPLE"]||
                  [self.queryStatus isEqualToString:@"SAMPLED"]){
            
            [params setObject:self.queryModel.samplingTimeFrom== nil?@"":self.queryModel.samplingTimeFrom forKey:@"samplingTimeFrom"];
            [params setObject:self.queryModel.samplingTimeTo== nil?@"":self.queryModel.samplingTimeTo forKey:@"samplingTimeTo"];
            
        } else if([self.queryStatus isEqualToString:@"WAIT_REGISTER"]||
                  [self.queryStatus isEqualToString:@"REGISTERED"]){
            [params setObject:self.queryModel.sn== nil?@"":self.queryModel.sn forKey:@"sn"];
            [params setObject:self.queryModel.inspectOrgId== nil?@"":self.queryModel.inspectOrgId forKey:@"inspectOrgId"];
            [params setObject:self.queryModel.acceptUserName== nil?@"":self.queryModel.acceptUserName forKey:@"acceptUserName"];
            [params setObject:self.queryModel.inspectResult== nil?@"":self.queryModel.inspectResult forKey:@"inspectResult"];
        }
        
        [params setObject:self.queryModel.entrustOrgName== nil?@"":self.queryModel.entrustOrgName forKey:@"entrustOrgName"];
        [params setObject:self.queryModel.sampleName== nil?@"":self.queryModel.sampleName forKey:@"sampleName"];
        [params setObject:self.queryModel.from== nil?@"":self.queryModel.from forKey:@"from"];
        [params setObject:self.queryModel.to== nil?@"":self.queryModel.to forKey:@"to"];
        [params setObject:self.queryModel.acceptTimeFrom== nil?@"":self.queryModel.acceptTimeFrom forKey:@"acceptTimeFrom"];
        [params setObject:self.queryModel.acceptTimeTo== nil?@"":self.queryModel.acceptTimeTo forKey:@"acceptTimeTo"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadDataForFirst {
    //第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        kSetMJRefresh(self.tableview);
        self.isDataLoaded = YES;
    }
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}
-(void)listDidAppear{
    [self loadDataForFirst];
    
}
#pragma mark - deleDate
#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}

#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_DelegateHandleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_DelegateHandleCell"];
    xw_EntrustInspectModel* model = self.dataSource[indexPath.section];
    model.queryStatus = self.queryStatus;
    model.indexPath = indexPath;
    cell.model = model;
    cell.refreshBlock = ^(xw_EntrustInspectModel * _Nonnull model, NSString * _Nonnull type) {
        if([type isEqualToString:@"fold"]){
            [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:model.indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        } else if([type isEqualToString:@"edit"]){
            NSLog(@"修改");
            [self putEntrustInspect:model];
            
        } else if([type isEqualToString:@"logistics"]){
            NSLog(@"查看物流");
            NSString *path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@?expressId=%@",@"MyCourierDetailViewController",model.id];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:path] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
        }
    };
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_EntrustInspectModel* model = self.dataSource[indexPath.section];
    CGFloat height = 0;
    if(model.isFold){
        if (![model.queryStatus isEqualToString:@"WAIT_ACCEPT"]) {
            if([model.queryStatus isEqualToString:@"REGISTERED"]){
                height = 660;
            } else {
                height = 540;
            }
        } else {
            height = 450;
        }
    } else {
        height = 150;
    }
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if([self.queryStatus isEqualToString:@"WAIT_ACCEPT"]||
       [self.queryStatus isEqualToString:@"WAIT_SAMPLE"]||
       [self.queryStatus isEqualToString:@"WAIT_REGISTER"]||
       [self.queryStatus isEqualToString:@"REGISTERED"]){
        return 70;
        
    } else {
        return 10;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    NSString* title;
    if([self.queryStatus isEqualToString:@"WAIT_ACCEPT"]||
       [self.queryStatus isEqualToString:@"ACCEPTED"]){
        title = @"委托记录单";
        
    } else if([self.queryStatus isEqualToString:@"WAIT_SAMPLE"]||
              [self.queryStatus isEqualToString:@"SAMPLED"]){
        title = @"采样记录单";
    } else if([self.queryStatus isEqualToString:@"WAIT_REGISTER"]||
              [self.queryStatus isEqualToString:@"REGISTERED"]){
        title = @"检测结果登记";
    }
    
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *titleLabel = [UILabel labelWithText:title WithTextColor:COLOR(@"#2A2A2A") WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:17];
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
    UIView* footer;
    if([self.queryStatus isEqualToString:@"WAIT_ACCEPT"]||
       [self.queryStatus isEqualToString:@"WAIT_SAMPLE"]||
       [self.queryStatus isEqualToString:@"WAIT_REGISTER"]||
       [self.queryStatus isEqualToString:@"REGISTERED"]){
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        if ([self.queryStatus isEqualToString:@"WAIT_ACCEPT"]) {
            UIButton *acceptBtn = [UIButton buttonWithTitie:@"受理" WithtextColor:COLOR(@"#206EEA") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
                
                NSLog(@"受理");
                DelegateHandleTabDetailViewController* vc = [DelegateHandleTabDetailViewController new];
                vc.type = @"ACCEPT";
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            ViewBorderRadius(acceptBtn, 5, 1, COLOR(@"#206EEA"));
            [footer addSubview:acceptBtn];
            
            UIButton *sendBtn = [UIButton buttonWithTitie:@"派单" WithtextColor:COLOR(@"#206EEA") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
                
                NSLog(@"派单");
                DelegateHandleTabDetailViewController* vc = [DelegateHandleTabDetailViewController new];
                vc.type = @"DISPATCH";
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            ViewBorderRadius(sendBtn, 5, 1, COLOR(@"#206EEA"));
            [footer addSubview:sendBtn];
            
            acceptBtn.sd_layout.leftSpaceToView(footer, 20).topSpaceToView(footer, 15).widthIs((SCREEN_WIDTH-60)/2).heightIs(30);
            sendBtn.sd_layout.rightSpaceToView(footer, 20).topSpaceToView(footer, 15).widthIs((SCREEN_WIDTH-60)/2).heightIs(30);
        } else if([self.queryStatus isEqualToString:@"WAIT_SAMPLE"]){
            UIButton *sampleBtn = [UIButton buttonWithTitie:@"采样" WithtextColor:COLOR(@"#206EEA") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {

                NSLog(@"采样");
                
                SamplingDetailViewController* vc = [SamplingDetailViewController new];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            ViewBorderRadius(sampleBtn, 5, 1, COLOR(@"#206EEA"));
            [footer addSubview:sampleBtn];
            
            sampleBtn.sd_layout.topSpaceToView(footer, 15).centerXEqualToView(footer).widthIs((SCREEN_WIDTH-60)/2).heightIs(30);
        } else if([self.queryStatus isEqualToString:@"WAIT_REGISTER"]){
            UIButton *resultsBtn = [UIButton buttonWithTitie:@"结果登记" WithtextColor:COLOR(@"#206EEA") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
                
                NSLog(@"结果登记");
                
                ResultsDetailViewController* vc = [ResultsDetailViewController new];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            ViewBorderRadius(resultsBtn, 5, 1, COLOR(@"#206EEA"));
            [footer addSubview:resultsBtn];
            
            resultsBtn.sd_layout.topSpaceToView(footer, 15).centerXEqualToView(footer).widthIs((SCREEN_WIDTH-60)/2).heightIs(30);
        } else if([self.queryStatus isEqualToString:@"REGISTERED"]){
            UIButton *qrBtn = [UIButton buttonWithTitie:@"证书二维码" WithtextColor:COLOR(@"#206EEA") WithBackColor:nil WithBackImage:nil WithImage:nil WithFont:15 EventBlock:^(id  _Nonnull params) {
                
                CertQrViewController* vc = [CertQrViewController new];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
                NSLog(@"证书二维码");
                
            }];
            ViewBorderRadius(qrBtn, 5, 1, COLOR(@"#206EEA"));
            [footer addSubview:qrBtn];
            
            qrBtn.sd_layout.topSpaceToView(footer, 15).centerXEqualToView(footer).widthIs((SCREEN_WIDTH-60)/2).heightIs(30);
        }
        
        
        
        UILabel* line = [UILabel new];
        line.backgroundColor = COLOR(@"#EEEEEE");
        [footer addSubview:line];
        line.sd_layout
        .leftEqualToView(footer)
        .rightEqualToView(footer)
        .bottomEqualToView(footer)
        .heightIs(10);
        
        
    } else {
        footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        footer.backgroundColor = COLOR(@"#eeeeee");
        
    }
    
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
        [_tableview registerClass:[xw_DelegateHandleCell class] forCellReuseIdentifier:@"xw_DelegateHandleCell"];
    }
    return _tableview;
}


-(void)putEntrustInspect:(xw_EntrustInspectModel*)model{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:model.id forKey:@"id"];
    [params setObject:model.sn forKey:@"sn"];
    [[self.viewModel.putEntrustInspectCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self xw_loadNewData];
        
    } error:^(NSError * _Nullable error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
    }];
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
