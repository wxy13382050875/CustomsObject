//
//  MyViewController.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

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
    self.title = @"我的";
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
//    self.view.backgroundColor = COLOR(@"#eeeeee");
//    [self.view addSubview:self.collectionView];
//    self.collectionView.sd_layout
//    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0)) ;
}
@end
