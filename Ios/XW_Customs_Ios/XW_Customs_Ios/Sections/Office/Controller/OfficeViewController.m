//
//  OfficeViewController.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "OfficeViewController.h"

#import "HeaderColReusableView.h"
#import "MenuColCell.h"
#import "xw_UserInfoModel.h"
#import "xw_EntrustModel.h"
static CGFloat kMagin = 1.f;
@import JJCollectionViewRoundFlowLayout;
@interface OfficeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionView;
@property(nonatomic,strong)xw_UserInfoModel* model;
@end

@implementation OfficeViewController

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
    self.title = @"办事";
}
-(void)xw_setupUI{
    [self.view addSubview:self.collectionView];
    self.collectionView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(10, 0, 0, 0)) ;
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
    self.model =  [xw_UserInfoModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].sUserInfo];
    [self.collectionView reloadData];
}
-(void)xw_loadNewData{
    
//    [self getData];
}
-(void)xw_loadMoreData{
}
-(void)getData{
}


#pragma mark UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.model.mobilePermissionTree.count;
}

//每个分组里有多少个item

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    MobilepermissiontreeModel* treeModel = self.model.mobilePermissionTree[section];
    return treeModel.children.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据identifier从缓冲池里去出cell

    MenuColCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MenuColCell class]) forIndexPath:indexPath];
    MobilepermissiontreeModel* treeModel = self.model.mobilePermissionTree[indexPath.section];
    cell.model = treeModel.children[indexPath.row];
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
    return CGSizeMake(SCREEN_WIDTH, 50);
    
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    
//    //kind有两种 一种时header 一种事footer
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeaderColReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderColReusableView class]) forIndexPath:indexPath];
//            header.bModel = tmModel;
        header.model = self.model.mobilePermissionTree[indexPath.section];

     

        return header;
        
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
    MobilepermissiontreeModel* treeModel = self.model.mobilePermissionTree[indexPath.section];
    SubTreeModel *subModel = treeModel.children[indexPath.row];
    //        if ([self.handleType isEqualToString:@"ACCEPT"]) {
    //            self.title = @"委托受理";
    //            self.titles = @[@"未受理",@"已受理"];
    //            self.status = @[@"WAIT_ACCEPT",@"ACCEPTED"];
    //        } else if ([self.handleType isEqualToString:@"SAMPLE"]) {
    //            self.title = @"采样记录";
    //            self.titles = @[@"待采样",@"已采样"];
    //            self.status = @[@"WAIT_SAMPLE",@"SAMPLED"];
    //        } else if ([self.handleType isEqualToString:@"REGISTER"]) {
    //            self.title = @"检测结果登记";
    //            self.titles = @[@"未完成",@"已完成"];
    //            self.status = @[@"WAIT_REGISTER",@"REGISTERED"];
    //        }
    NSString *path;
    xw_EntrustModel* enModel = [xw_EntrustModel mj_objectWithKeyValues:[xw_ConfigHelper sharedInstance].entrustOrg];
    
    if([subModel.name isEqualToString:@"委托受理"]){
        path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@?handleType=ACCEPT",subModel.iosPath];
    } else if([subModel.name isEqualToString:@"采样记录"]){
        path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@?handleType=SAMPLE",subModel.iosPath];
    } else if([subModel.name isEqualToString:@"检测登记"]){
        
        path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@?handleType=REGISTER",subModel.iosPath];
    } else if([subModel.name isEqualToString:@"委托检验"] && enModel == nil){
        
        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(@"请完善委托单位信息").wDisappelSecondSet(1).wStart();
        return;
    } else {
        
        path = [NSString stringWithFormat:@"XWMVVMRACRouter://NaviPush/%@",subModel.iosPath];
    }
    
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
        
        
//        //注册header
        [_collectionView registerClass:[HeaderColReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderColReusableView class])];

        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
@end
