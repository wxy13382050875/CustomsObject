//
//  DelegateHandleViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/2.
//

#import "DelegateHandleViewController.h"
#import "DelegateHandleTabViewController.h"
#import "xw_ScreenViewController.h"
#import "xw_HandleQueryModel.h"
@interface DelegateHandleViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *types;

@property (nonatomic, strong) NSArray *status;

@property (nonatomic, strong) xw_HandleQueryModel *queryModel;

@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation DelegateHandleViewController

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
//    self.title = @"委托受理";
//    self.title = @"采样记录";
//    self.title = @"检测结果登记";
    UIButton* screenBtn =[UIButton buttonWithTitie:@"筛选" WithtextColor:COLOR(@"#1F7EFE") WithBackColor:nil WithBackImage: nil WithImage:IMG(@"icon_screen") WithFont:17 EventBlock:^(id  _Nonnull params) {
        GGLog(@"筛选");
        xw_ScreenViewController *vc = [[xw_ScreenViewController alloc] init];
        vc.handleType = self.handleType;
        vc.model = self.queryModel;
        vc.refreshBlock = ^(xw_HandleQueryModel * _Nonnull model) {
            self.queryModel = model;
//            [self.listContainerView reloadData];
            [KNotificationCenter postNotificationName:kRefreshNotification object:nil userInfo:@{@"state":self.status[self.currentIndex],@"model":self.queryModel}];
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
    if ([self.handleType isEqualToString:@"ACCEPT"]) {
        self.title = @"委托受理";
        self.titles = @[@"未受理",@"已受理"];
        self.status = @[@"WAIT_ACCEPT",@"ACCEPTED"];
    } else if ([self.handleType isEqualToString:@"SAMPLE"]) {
        self.title = @"采样记录";
        self.titles = @[@"待采样",@"已采样"];
        self.status = @[@"WAIT_SAMPLE",@"SAMPLED"];
    } else if ([self.handleType isEqualToString:@"REGISTER"]) {
        self.title = @"检测结果登记";
        self.titles = @[@"未完成",@"已完成"];
        self.status = @[@"WAIT_REGISTER",@"REGISTERED"];
    }
    
    self.types = @[@(JXCategoryTitleImageType_OnlyTitle),
                   @(JXCategoryTitleImageType_OnlyTitle)];
    
    [self.view addSubview:self.categoryView];
    self.categoryView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(40);
    [self.view addSubview:self.listContainerView];
    self.listContainerView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.categoryView, 0)
    .bottomEqualToView(self.view);
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
    self.currentIndex = index;
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
    DelegateHandleTabViewController* list = [[DelegateHandleTabViewController alloc] init];
    list.naviController = self.navigationController;
    list.title = self.titles[index];
    list.queryStatus = self.status[index];
    list.didScrollCallback = ^(UIScrollView *scrollView) {
//        !weakSelf_SC.didScrollCallback ?: weakSelf_SC.didScrollCallback(scrollView);
    };
    return list;
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



@end
