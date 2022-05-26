//
//  HomeViewController.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "HomeViewController.h"
#import "BannerColCell.h"
#import "MenuColCell.h"
#import "CentreColCell.h"
#import "NewsInfoColCell.h"
#import "FAQColCell.h"
#import "HeaderColReusableView.h"
static CGFloat kMagin = 1.f;
@import JJCollectionViewRoundFlowLayout;
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)UITextField* searchTextField;
@end

@implementation HomeViewController

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
    UIButton* logoBtn = [UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:IMG(@"icon_nav_logo")  WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
        GGLog(@"左侧图标");
    }];
    UIButton* scanBtn =[UIButton buttonWithTitie:@"" WithtextColor:nil WithBackColor:nil WithBackImage:IMG(@"icon_scan")  WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
        GGLog(@"扫一扫");
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
    self.navigationItem.titleView = self.searchTextField;
}

-(void)xw_setupUI{
    [self.view addSubview:self.collectionView];
    self.collectionView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0)) ;
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


#pragma mark UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}

//每个分组里有多少个item

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(section == 1){
        return 4;
    } else if(section == 2){
        return 2;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据identifier从缓冲池里去出cell

    if (indexPath.section == 0) {
        BannerColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BannerColCell class]) forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 1) {
        MenuColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MenuColCell class]) forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        CentreColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CentreColCell class]) forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 3) {
        NewsInfoColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NewsInfoColCell class]) forIndexPath:indexPath];
        return cell;
    } else {
        FAQColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FAQColCell class]) forIndexPath:indexPath];
        return cell;
        
    }
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 150);
    } else if (indexPath.section == 1) {
        return CGSizeMake((SCREEN_WIDTH-5)/4, 120);
    } else if (indexPath.section == 2) {
        return CGSizeMake((SCREEN_WIDTH-3)/2, 85);
    }  else if (indexPath.section == 3) {
        return CGSizeMake(SCREEN_WIDTH, 80);
    } else {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    
    
}
#pragma mark - JJCollectionViewDelegateRoundFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

- (JJCollectionViewRoundConfigModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section{

    JJCollectionViewRoundConfigModel *model = [[JJCollectionViewRoundConfigModel alloc]init];

    model.cornerRadius = 0;
    model.backgroundColor = [UIColor whiteColor];
//    model.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//    model.shadowOffset = CGSizeMake(0,0);
//    model.shadowOpacity = 1;
//    model.shadowRadius = 4;



    return model;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 3 || section == 4) {
        return CGSizeMake(SCREEN_WIDTH, 50);
        
    }
    return CGSizeZero;
    
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    
//    //kind有两种 一种时header 一种事footer
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section == 3 || indexPath.section == 4) {
//            BodyModel* tmModel = self.model.body[indexPath.section -1];
            HeaderColReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderColReusableView class]) forIndexPath:indexPath];
//            header.bModel = tmModel;

            header.didChickEventBlock = ^(id params) {
//                xw_NewsViewController* viewController = [xw_NewsViewController new];
//                viewController.moduleId = [NSString stringWithFormat:@"%ld",(long)params.moduleId];
//                [self.navigationController pushViewController:viewController animated:YES];
            };

            return header;
                
        }
        
    }
    return nil;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 5, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
}

#pragma mark 懒加载
-(UICollectionView*)collectionView{
    if (!_collectionView) {
         JJCollectionViewRoundFlowLayout *layout = [[JJCollectionViewRoundFlowLayout alloc]init];
         layout.scrollDirection = UICollectionViewScrollDirectionVertical;
         layout.isCalculateHeader = YES;
         layout.isCalculateFooter = NO;


        //设置senction的内边距
        layout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);

        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        
        _collectionView.backgroundColor =COLOR(@"#FFFFFF");
        //注册cell banner
        [_collectionView registerClass:[BannerColCell class] forCellWithReuseIdentifier:NSStringFromClass([BannerColCell class])];
        //注册cell 菜单
        [_collectionView registerClass:[MenuColCell class] forCellWithReuseIdentifier:NSStringFromClass([MenuColCell class])];
        //注册cell 技术中心
        [_collectionView registerClass:[CentreColCell class] forCellWithReuseIdentifier:NSStringFromClass([CentreColCell class])];
        //注册cell 新闻资讯
        [_collectionView registerClass:[NewsInfoColCell class] forCellWithReuseIdentifier:NSStringFromClass([NewsInfoColCell class])];
        
        //注册cell 常见问题
        [_collectionView registerClass:[FAQColCell class] forCellWithReuseIdentifier:NSStringFromClass([FAQColCell class])];
        
//        //注册header
        [_collectionView registerClass:[HeaderColReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderColReusableView class])];

        _collectionView.backgroundColor =[UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
-(UITextField*)searchTextField{
    if(!_searchTextField){
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH -100, kNavBarHeight)];
        _searchTextField.font = FONT(10);
        _searchTextField.textColor = COLOR(@"#A1A1A1");
        _searchTextField.placeholder = @"输入证书编码";
        _searchTextField.backgroundColor = COLOR(@"#F5F5F5");
        _searchTextField.returnKeyType = UIReturnKeySearch;
        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kNavBarHeight, kNavBarHeight)];
        UIImageView* imageView = [UIImageView new];
        imageView.image = IMG(@"icon_search");
        [leftView addSubview:imageView];
        imageView.sd_layout.centerXEqualToView(leftView)
        .centerYEqualToView(leftView).widthIs(16).heightIs(16);
        _searchTextField.leftView = leftView;‘«
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        ViewRadius(_searchTextField, 5);
    }
    return _searchTextField;
}
@end
