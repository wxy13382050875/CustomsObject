//
//  HomeViewController.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "HomeViewController.h"
#import "CenterTabViewController.h"
#import "SubCenterTabViewController.h"
@interface HomeViewController ()<UITextFieldDelegate,JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *types;

@property (nonatomic, strong) UIView *navView;
@property(nonatomic,strong)UITextField* searchTextField;
@property (nonatomic, strong) UIButton *logoBtn;
@property (nonatomic, strong) UIButton *scanBtn;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *jxBgView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
//    UIButton* logoBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:IMG(@"icon_nav_logo")  WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
//        GGLog(@"左侧图标");
//    }];
//    UIButton* scanBtn =[UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:IMG(@"icon_scan")  WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
//        GGLog(@"扫一扫");
//        [self skipCertificateQueryViewController];
//    }];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoBtn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
//    self.navigationItem.titleView = self.searchTextField;
    
}


-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    
}
-(void)xw_loadNewData{
    
    [self getData];
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
    self.titles = @[@"技术中心",@"技术分中心"];
    
    self.types = @[@(JXCategoryTitleImageType_OnlyTitle),
                   @(JXCategoryTitleImageType_OnlyTitle)];
    
    [self.view addSubview:self.bgView];
    self.bgView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(300);
    
    [self.view addSubview:self.navView];
    self.navView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.view, kStatusBarHeight);
    
    [self.navView addSubview:self.logoBtn];
    self.logoBtn.sd_layout
    .leftSpaceToView(self.navView, 5)
    .centerYEqualToView(self.navView)
    .widthIs(35).heightIs(35);
    [self.navView addSubview:self.scanBtn];
    self.scanBtn.sd_layout
    .rightSpaceToView(self.navView, 5)
    .centerYEqualToView(self.navView)
    .widthIs(35).heightIs(35);
    
    [self.navView addSubview:self.searchTextField];
    self.searchTextField.sd_layout
    .leftSpaceToView(self.logoBtn, 5)
    .rightSpaceToView(self.scanBtn, 5)
    .centerYEqualToView(self.navView)
    .heightIs(35);
    
    
    
    [self.view addSubview:self.jxBgView];
    self.jxBgView.sd_layout
    .leftSpaceToView(self.view, 5)
    .rightSpaceToView(self.view, 5)
    .topSpaceToView(self.navView, 20)
    .bottomSpaceToView(self.view, 5);
    
    [self.jxBgView addSubview:self.categoryView];
    self.categoryView.sd_layout
    .topEqualToView(self.jxBgView)
    .leftEqualToView(self.jxBgView)
    .rightEqualToView(self.jxBgView)
    .heightIs(40);
    
    [self.jxBgView addSubview:self.listContainerView];
    self.listContainerView.sd_layout
    .leftEqualToView(self.jxBgView)
    .rightEqualToView(self.jxBgView)
    .topSpaceToView(self.categoryView, 0)
    .bottomEqualToView(self.jxBgView);
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
//
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
//
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
//    self.list.title = self.titles[index];
    [self.listContainerView didClickSelectedItemAtIndex:index];
    
}
//
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
//    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
    
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if(index == 0){
        CenterTabViewController* list = [[CenterTabViewController alloc] init];
        list.type = @"tab";
        list.orgId = @"1";
        list.naviController = self.navigationController;
        return list;
    } else {
        SubCenterTabViewController* list = [[SubCenterTabViewController alloc] init];
        list.naviController = self.navigationController;
        return list;
    }

    
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
-(UIScrollView*)scrollViewInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    scrollView.scrollEnabled = NO;
    return scrollView;
}
-(JXCategoryTitleImageView*)categoryView{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleImageView alloc] init];
        _categoryView.backgroundColor = COLOR(@"#ffffff");
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.delegate = self;
        _categoryView.titleColor = COLOR(@"#898989");
        _categoryView.titleSelectedColor = COLOR(@"#1F7EFE");
        _categoryView.titleFont = FONT(15);
        _categoryView.titleSelectedFont = FONT(15);
        
        _categoryView.cellSpacing = 0;
        _categoryView.contentEdgeInsetLeft = 0;
        _categoryView.contentEdgeInsetRight = 0;
        _categoryView.averageCellSpacingEnabled = NO;
        _categoryView.cellWidth = SCREEN_WIDTH/2;
        
        _categoryView.titles = self.titles;
        _categoryView.imageTypes = self.types;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = COLOR(@"#1F7EFE");
        lineView.indicatorWidth = 30;
            //配置titleView的下划线
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}
-(JXCategoryListContainerView*)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
//        _listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
        _listContainerView.defaultSelectedIndex = 0;
    }
    return _listContainerView;
}

-(UITextField*)searchTextField{
    if(!_searchTextField){
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -100, 35)];
        _searchTextField.font = FONT(10);
        _searchTextField.textColor = COLOR(@"#A1A1A1");
        _searchTextField.placeholder = @"输入证书编码";
        _searchTextField.backgroundColor = COLOR(@"#F5F5F5");
        _searchTextField.returnKeyType = UIReturnKeySearch;
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kNavBarHeight, 35)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_search");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(16).heightIs(16);
        
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        ViewRadius(_searchTextField, 5);
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [self skipCertificateQueryViewController];
    return NO;
}
-(void)skipCertificateQueryViewController{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"XWMVVMRACRouter://NaviPush/CertificateQueryViewController"] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = COLOR(@"#206EEA");
    }
    return _bgView;
}


- (UIView *)jxBgView {
    if (!_jxBgView) {
        _jxBgView = [[UIView alloc] init];
        _jxBgView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_jxBgView, 15);
    }
    return _jxBgView;
}


- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] init];
        _navView.backgroundColor = [UIColor clearColor];
    }
    return _navView;
}

- (UIButton *)logoBtn {
    if (!_logoBtn) {
        _logoBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:IMG(@"icon_nav_logo")  WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            GGLog(@"左侧图标");
        }];
            
        
     }
    return _logoBtn;
}

- (UIButton *)scanBtn {
    if (!_scanBtn) {
        _scanBtn =[UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:IMG(@"icon_nav_scan")  WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
                GGLog(@"扫一扫");
                [self skipCertificateQueryViewController];
        }];
       
     }
    return _scanBtn;
}

@end
