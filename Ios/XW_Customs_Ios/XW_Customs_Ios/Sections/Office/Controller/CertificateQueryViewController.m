//
//  CertificateQueryViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "CertificateQueryViewController.h"
#import "xw_CertificateQueryCell.h"
#import "xw_OfficeViewModel.h"
#import "xw_ScanQRViewController.h"
@interface CertificateQueryViewController () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) xw_OfficeViewModel *viewModel;
@property (nonatomic,strong)  NSString* qrCodeContent;


@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *scanBtn;

@property (nonatomic, strong) xw_EntrustInspectModel *model;
@end

@implementation CertificateQueryViewController

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
    self.title = @"证书查询";
    [self.navigationController.navigationBar xw_setBackgroundColor:[UIColor whiteColor]];
}
-(void)xw_bindViewModel{
//    if(self.model != nil){
//        [self.tableview reloadData];
//    }
}

-(void)xw_loadDataSource{
    if (self.strModel!= nil) {
        self.searchView.hidden = YES;
//        self.model.entrustOrgName = _model.entrustOrg.name;
        self.model = [xw_EntrustInspectModel mj_objectWithKeyValues:self.strModel];
        self.model.entrustOrgName = self.model.entrustOrg.name;
        [self.tableview reloadData];
    }
//    [self getData];
}
-(void)xw_loadNewData{
    
    
}
-(void)xw_loadMoreData{
//    if ([self.collectionView.mj_header isRefreshing]) {
//        return;
//    }
//    [self getData];
}
-(void)getData:(NSString*)qrCodeContent{
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    [params setObject:qrCodeContent forKey:@"qrCodeContent"];
    [self.view showLoadingMeg:@"正在加载"];
    [[self.viewModel.getCertByQrCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        [self.view hideLoading];
        self.model = [xw_EntrustInspectModel mj_objectWithKeyValues:x[@"data"]];
        if(self.model == nil){
            Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"未查到相关检测证书").wDisappelSecondSet(1).wStart();
        } else {
            [self.tableview reloadData];
        }
        

    } error:^(NSError * _Nullable error) {
        [self.view hideLoading];
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
    }];
}
-(void)xw_setupUI{
    [self.view addSubview:self.tableview];
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, 0, 0)) ;
    
    
    [self.view addSubview:self.searchView];
    self.searchView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(kNavBarHeight);
    [self.searchView addSubview:self.scanBtn];
    self.scanBtn.sd_layout
    .rightSpaceToView(self.searchView, 10)
    .centerYEqualToView(self.searchView)
    .widthIs(35).heightIs(35);
    
    [self.searchView addSubview:self.searchTextField];
    self.searchTextField.sd_layout
    .leftSpaceToView(self.searchView, 10)
    .rightSpaceToView(self.scanBtn, 10)
    .centerYEqualToView(self.searchView)
    .heightIs(35);
    
    
    
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    xw_CertificateQueryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_CertificateQueryCell"];
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([xw_CertificateQueryCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
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
        [_tableview registerClass:[xw_CertificateQueryCell class] forCellReuseIdentifier:@"xw_CertificateQueryCell"];
    }
    return _tableview;
}

- (xw_OfficeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_OfficeViewModel alloc] init];
    }
    return _viewModel;
}


- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        _searchView.backgroundColor = [UIColor whiteColor];
    }
    return _searchView;
}


- (UITextField *)searchTextField {
    if(!_searchTextField){
        _searchTextField = [UITextField new];
        _searchTextField.font = FONT(13);
        _searchTextField.textColor = COLOR(@"#171717");
        _searchTextField.textAlignment = NSTextAlignmentLeft;
        _searchTextField.placeholder = @"输入证书编码";
        _searchTextField.backgroundColor = COLOR(@"#F5F5F5");
        _searchTextField.returnKeyType = UIReturnKeySearch;
        ViewRadius(_searchTextField, 5);
        @weakify(self);
        [_searchTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.model.inspectOrgId = x;
        }];
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_search");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(20).heightIs(20);
        
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}

- (UIButton *)scanBtn {
    if (!_scanBtn) {
        _scanBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:nil WithImage:IMG(@"icon_scan") WithFont:15 EventBlock:^(id  _Nonnull params) {
            xw_ScanQRViewController* vc = [xw_ScanQRViewController new];
            vc.scanDataBlock = ^(NSString * _Nonnull qrCode) {
                [self getData:qrCode];
            };
            [self presentViewController:vc animated:YES completion:nil];
        }];
     }
    return _scanBtn;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(![textField.text isEqualToString:@""]){
        NSLog(@"textField 不为空");
        [self getData:textField.text];
    } else {
        NSLog(@"textField 为空");
    }
        
    return YES;
}
-(xw_EntrustInspectModel*) model {
    if(!_model){
        _model = [xw_EntrustInspectModel new];
    }
    return _model;
}

@end
