//
//  DelegateInspectionViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/5/31.
//

#import "DelegateInspectionViewController.h"
#import "MenuColCell.h"
#import "xw_UserInfoModel.h"
static CGFloat kMagin = 1.f;
@import JJCollectionViewRoundFlowLayout;
@interface DelegateInspectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation DelegateInspectionViewController

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
    self.title = @"委托检验";
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
//    [[self.viewModel.msgGroupCommand execute:@{}] subscribeNext:^(id  _Nullable x) {
//        self.dataSource = [xw_MsgGroupModel mj_objectArrayWithKeyValuesArray:x[@"data"]];
//        [self.tableview reloadData];
//
//    } error:^(NSError * _Nullable error) {
//
//    }];
    [self.dataSource removeAllObjects];
    
    SubTreeModel *model = [SubTreeModel new];
    model.name = @"委托记录";
    model.iosPath = @"DelegateRecordViewController";
    model.localIcon = @"icon_delegate_record";
    [self.dataSource addObject:model];
    
    SubTreeModel *model1 = [SubTreeModel new];
    model1.name = @"委托申请";
    model1.iosPath = @"DelegateApplyViewController";
    model1.localIcon = @"icon_delegate_apply";
    [self.dataSource addObject:model1];
}
-(void)xw_setupUI{
    [self.view addSubview:self.collectionView];
    self.collectionView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, 0, 0)) ;
}

#pragma mark - tableView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个分组里有多少个item

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据identifier从缓冲池里去出cell

    MenuColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MenuColCell class]) forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-5)/3, 95);
    
    
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
    return CGSizeZero;
    
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    
//    //kind有两种 一种时header 一种事footer
    
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
    SubTreeModel *subModel = self.dataSource[indexPath.row];

    
    NSString *path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@",subModel.iosPath];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:path] options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:nil];
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
       
        //注册cell 菜单
        [_collectionView registerClass:[MenuColCell class] forCellWithReuseIdentifier:NSStringFromClass([MenuColCell class])];
        

        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
