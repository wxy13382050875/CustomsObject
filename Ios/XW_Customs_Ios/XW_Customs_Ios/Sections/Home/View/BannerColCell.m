//
//  BannerColCell.m
//  XW_Customs_Ios
//
//  Created by wuxinyi on 2022/5/7.
//

#import "BannerColCell.h"
#import <ZKCycleScrollView/ZKCycleScrollView.h>
#import "ImageBannerCelCell.h"
@interface BannerColCell ()<ZKCycleScrollViewDelegate, ZKCycleScrollViewDataSource>

@property (nonatomic, strong) ZKCycleScrollView *imageCycleScrollView;

@end
@implementation BannerColCell
-(void)xw_setupUI{
    [self addSubview:self.imageCycleScrollView];
}
-(void)xw_updateConstraints{
    self.imageCycleScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(15, 10, 0, 10));
    [self.imageCycleScrollView reloadData];
}
//-(void)setModel:(HeaderModel *)model{
//    _model = model;
//    [self.imageCycleScrollView reloadData];
//}
#pragma mark -- ZKCycleScrollView DataSource
- (NSInteger)numberOfItemsInCycleScrollView:(ZKCycleScrollView *)cycleScrollView {
    return 3;
}

- (__kindof ZKCycleScrollViewCell *)cycleScrollView:(ZKCycleScrollView *)cycleScrollView cellForItemAtIndex:(NSInteger)index {
    ImageBannerCelCell *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageBannerCelCell class]) forIndex:index];
//    cell.model = self.model.banner[index];
    return cell;
}

#pragma mark -- ZKCycleScrollView Delegate
- (void)cycleScrollView:(ZKCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {

}
#pragma mark 懒加载
-(ZKCycleScrollView*)imageCycleScrollView{
    if (!_imageCycleScrollView) {
        _imageCycleScrollView = [[ZKCycleScrollView alloc] initWithFrame:CGRectZero shouldInfiniteLoop:NO];
        _imageCycleScrollView.delegate = self;
        _imageCycleScrollView.dataSource = self;
        [_imageCycleScrollView registerCellClass:[ImageBannerCelCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageBannerCelCell class])];
        ViewRadius(_imageCycleScrollView, 10);
    }
    return _imageCycleScrollView;
}
@end
