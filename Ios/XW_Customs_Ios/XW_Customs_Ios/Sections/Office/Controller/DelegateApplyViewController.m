//
//  DelegateApplyViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/2.
//

#import "DelegateApplyViewController.h"
#import "xw_DelegateApplyCell.h"
#import "xw_OfficeViewModel.h"
@interface DelegateApplyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property(nonatomic,strong)UIButton* saveBtn;
@property(nonatomic,strong)UIButton* confirmBtn;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@end

@implementation DelegateApplyViewController

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
    self.title = @"委托申请";
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    if ([self.type isEqualToString:@"detail"]) {
        [self.tableview reloadData];
    } else {
        [self getData];
    }
    
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
    [[self.viewModel.getOneCacheCommand execute:@{}] subscribeNext:^(id  _Nullable x) {
        self.model = [xw_EntrustInspectModel mj_objectWithKeyValues:x[@"data"]];
        [self.tableview reloadData];

    } error:^(NSError * _Nullable error) {
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
    }];
}
-(void)xw_setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.confirmBtn];
    if ([self.type isEqualToString:@"detail"]) {
        self.saveBtn.hidden = YES;
        self.confirmBtn.sd_layout
        .centerXEqualToView(self.view)
        .bottomSpaceToView(self.view, kBottomSafeHeight)
        .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
    } else {
        self.saveBtn.sd_layout
        .leftSpaceToView(self.view, 20)
        .bottomSpaceToView(self.view, kBottomSafeHeight)
        .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
        
        self.confirmBtn.sd_layout
        .rightSpaceToView(self.view, 20)
        .bottomSpaceToView(self.view, kBottomSafeHeight)
        .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
    }
    
    
    
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, kBottomSafeHeight + 50, 0)) ;
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_DelegateApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_DelegateApplyCell"];
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_DelegateApplyCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
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
        [_tableview registerClass:[xw_DelegateApplyCell class] forCellReuseIdentifier:@"xw_DelegateApplyCell"];
    }
    return _tableview;
}

-(UIButton*)saveBtn{
    if(!_saveBtn){
        _saveBtn = [UIButton buttonWithTitie:@"暂存" WithtextColor:COLOR(@"#206EEA") WithBackColor:COLOR(@"#D8E7FF") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            NSLog(@"暂存%@",self.model.mj_JSONString);
            [self.view showLoadingMeg:@"正在提交"];
            [[self.viewModel.postCacheCommand execute:[self.model mj_JSONObject]] subscribeNext:^(id  _Nullable x) {
                [self.view hideLoading];
                [self.navigationController popViewControllerAnimated:YES];

            } error:^(NSError * _Nullable error) {
                [self.view hideLoading];
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();

            }];
        }];
        ViewRadius(_saveBtn, 5);
    }
    return _saveBtn;
}
-(UIButton*)confirmBtn{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithTitie:@"提交" WithtextColor:COLOR(@"#FFFFFF") WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            NSLog(@"确认%@",self.model.mj_JSONString);
            if(self.model.sampleName == nil || [self.model.sampleName isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"样品名称不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.sampleNum == nil || [self.model.sampleNum isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"样品份数不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.spec == nil || [self.model.spec isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"规格型号不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.productionDate == nil || [self.model.productionDate isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"生产日期不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.sampleQuantity == nil || [self.model.sampleQuantity isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"样品数量/重量不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.producer == nil || [self.model.producer isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"生产商不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.producerAddress == nil || [self.model.producerAddress isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"生产商地址不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            
            if(self.model.inspectOrgId == nil || [self.model.inspectOrgId isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"检测机构不能为空！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.takeWay == nil || [self.model.takeWay isEqualToString:@""]){
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"请选择报告拿取方式！").wDisappelSecondSet(1).wStart();
                return;
            }
            if(self.model.entrustOrgId == nil || [self.model.entrustOrgId isEqualToString:@""]){
                xw_EntrustModel* tm = [xw_EntrustModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].entrustOrg];
                self.model.entrustOrgId = tm.id;
            }
            [self.view showLoadingMeg:@"正在提交"];
            [[self.viewModel.postApplyCommand execute:[self.model mj_JSONObject]] subscribeNext:^(id  _Nullable x) {
                [self.view hideLoading];
                [self.navigationController popViewControllerAnimated:YES];

            } error:^(NSError * _Nullable error) {
                [self.view hideLoading];
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();

            }];
          
        }];
        ViewRadius(_confirmBtn, 5);
    }
    return _confirmBtn;
}
- (xw_EntrustInspectModel *)model {
    if (!_model) {
        _model = [[xw_EntrustInspectModel alloc] init];
    }
    return _model;
}
- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}

@end
