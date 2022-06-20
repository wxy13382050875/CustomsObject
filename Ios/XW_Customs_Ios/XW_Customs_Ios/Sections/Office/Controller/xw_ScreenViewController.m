//
//  xw_ScreenViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/10.
//

#import "xw_ScreenViewController.h"
#import "xw_AccetpCell.h"
#import "xw_SampleCell.h"
#import "xw_RegisterCell.h"
#import "xw_CertCell.h"
#import "xw_RecordCell.h"
@interface xw_ScreenViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)UIButton* resetBtn;
@property(nonatomic,strong)UIButton* confirmBtn;

@end

@implementation xw_ScreenViewController

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
}
-(void)xw_bindViewModel{
    
}
-(void)xw_loadDataSource{
}
-(void)xw_loadNewData{
    
}
-(void)xw_loadMoreData{
}
-(void)getData{
    
    
}
-(void)xw_setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.resetBtn];
    [self.view addSubview:self.confirmBtn];
    self.resetBtn.sd_layout
    .leftEqualToView(self.view)
    .bottomSpaceToView(self.view, kBottomSafeHeight)
    .heightIs(50).widthIs(SCREEN_WIDTH* 0.75/2);
    
    self.confirmBtn.sd_layout
    .leftSpaceToView(self.resetBtn, 0)
    .bottomSpaceToView(self.view, kBottomSafeHeight)
    .heightIs(50).widthIs(SCREEN_WIDTH* 0.75/2);
    
    
    self.tableview.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kNavBarAndStatusBarHeight, 0, kBottomSafeHeight, 0)) ;
}
#pragma mark - tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.handleType isEqualToString:@"ACCEPT"]){//委托受理
        xw_AccetpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_AccetpCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if([self.handleType isEqualToString:@"SAMPLE"]){//采样记录
        xw_SampleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_SampleCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if([self.handleType isEqualToString:@"REGISTER"]){//检测登记
        xw_RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_RegisterCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }  else if([self.handleType isEqualToString:@"CERTIFICATE"]){//检测登记
        xw_CertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_CertCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if([self.handleType isEqualToString:@"DELEGATERECORD"]){//检测登记
        xw_RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xw_RecordCell"];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT - kNavBarAndStatusBarHeight - kBottomSafeHeight;
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
        [_tableview registerClass:[xw_AccetpCell class] forCellReuseIdentifier:@"xw_AccetpCell"];
        [_tableview registerClass:[xw_SampleCell class] forCellReuseIdentifier:@"xw_SampleCell"];
        [_tableview registerClass:[xw_RegisterCell class] forCellReuseIdentifier:@"xw_RegisterCell"];
        [_tableview registerClass:[xw_CertCell class] forCellReuseIdentifier:@"xw_CertCell"];
        [_tableview registerClass:[xw_RecordCell class] forCellReuseIdentifier:@"xw_RecordCell"];
    }
    return _tableview;
}
-(UIButton*)resetBtn{
    if(!_resetBtn){
        _resetBtn = [UIButton buttonWithTitie:@"重置" WithtextColor:COLOR(@"#206EEA") WithBackColor:COLOR(@"#D8E7FF") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            NSLog(@"重置");
            self.model.sn = @"";
            self.model.sampleName = @"";
            self.model.inspectOrgId = [xw_ConfigHelper sharedInstance].orgsId;
            self.model.inspectOrgName = @"";
            self.model.entrustOrgName = @"";
            self.model.acceptUserName = @"";
            self.model.from = @"";
            self.model.to = @"";
            self.model.createTime = @"";
            self.model.acceptTimeFrom = @"";
            self.model.acceptTimeTo = @"";
            self.model.acceptTime = @"";
            [self.tableview reloadData];
        }];
    }
    return _resetBtn;
}
-(UIButton*)confirmBtn{
    if(!_confirmBtn){
        _confirmBtn = [UIButton buttonWithTitie:@"确认" WithtextColor:COLOR(@"#FFFFFF") WithBackColor:COLOR(@"#206EEA") WithBackImage:nil WithImage:nil WithFont:17 EventBlock:^(id  _Nonnull params) {
            NSLog(@"确认%@",self.model.mj_JSONString);
            if(self.refreshBlock){
                self.refreshBlock(self.model);
            }
        }];
    }
    return _confirmBtn;
}
- (xw_HandleQueryModel *)model {
    if (!_model) {
        _model = [[xw_HandleQueryModel alloc] init];
    }
    return _model;
}
@end
