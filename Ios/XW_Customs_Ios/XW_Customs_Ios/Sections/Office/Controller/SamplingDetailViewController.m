//
//  SamplingDetailViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "SamplingDetailViewController.h"

#import "xw_SamplingDetailCell.h"
#import "xw_OfficeViewModel.h"
@interface SamplingDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;

@property (nonatomic, strong) NSString *qrCode;
@end

@implementation SamplingDetailViewController

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
    self.title = @"采样记录";
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    self.model.sampleWay = nil;
    self.model.samplingNote = @"";
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
    
}
-(void)xw_setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    
    self.btn1.sd_layout
    .leftSpaceToView(self.view, 20)
    .bottomSpaceToView(self.view, kBottomSafeHeight)
    .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
    
    self.btn2.sd_layout
    .rightSpaceToView(self.view, 20)
    .bottomSpaceToView(self.view, kBottomSafeHeight)
    .heightIs(50).widthIs((SCREEN_WIDTH-60)/2);
    
    
    
    
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, kBottomSafeHeight + 50, 0)) ;
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_SamplingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_SamplingDetailCell"];
    cell.model = self.model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_SamplingDetailCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
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
        [_tableview registerClass:[xw_SamplingDetailCell class] forCellReuseIdentifier:@"xw_SamplingDetailCell"];
    }
    return _tableview;
}

- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}
-(UIButton*)btn1{
    if(!_btn1){
        _btn1 = [UIButton buttonWithTitie:@"取消" WithtextColor:COLOR(@"#206EEA") WithBackColor:COLOR(@"#D8E7FF") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        ViewRadius(_btn1, 5);
    }
    return _btn1;
}
-(UIButton*)btn2{
    if(!_btn2){
        _btn2 = [UIButton buttonWithTitie:@"确认" WithtextColor:COLOR(@"#FFFFFF") WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            
            [self postEntrustInspect:@"SAMPLING"];
        }];
        ViewRadius(_btn2, 5);
    }
    return _btn2;
}
-(void) postEntrustInspect:(NSString*)subType{
    if([self.model.sampleWay isEqualToString:@""]||self.model.sampleWay == nil){
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"请选择采样方式").wDisappelSecondSet(1).wStart();
        return;
    }
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.model.id forKey:@"id"];
    [params setObject:subType forKey:@"subType"];
    [params setObject:self.model.sampleWay forKey:@"sampleWay"];
    [params setObject:self.model.samplingNote forKey:@"samplingNote"];
    NSLog(@"params = %@",[NSString DataTOjsonString:params]);
    [self.view showLoadingMeg:@"正在提交"];
    [[self.viewModel.postEntrustInspectCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self.view hideLoading];
        [KNotificationCenter postNotificationName:kRefreshNotification object:nil userInfo:@{@"state":@""}];
        [self.navigationController popViewControllerAnimated:YES];

    } error:^(NSError * _Nullable error) {
        [self.view hideLoading];
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();

    }];
}
@end
