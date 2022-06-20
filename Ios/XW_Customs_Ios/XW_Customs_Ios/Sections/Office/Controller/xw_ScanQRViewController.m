//
//  xw_ScanQRViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "xw_ScanQRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SDScanView.h"
@interface xw_ScanQRViewController ()<SDScanViewDelegate>
//@property(nonatomic,strong)SDScanView *scanview ;
@end

@implementation xw_ScanQRViewController

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
    SDScanView *scanview = [[SDScanView alloc] init];
    scanview.delegate = self;
    [self.view addSubview:scanview];
}
- (void)SDScanViewOutputMetadataObjects:(NSArray *)metadataObjs{
    //
    AVMetadataMachineReadableCodeObject *obj = [metadataObjs objectAtIndex:0];
    NSLog(@"码数据:%@",obj.stringValue);
    NSLog(@"码类型:%@",obj.type);
    if(self.scanDataBlock){
        self.scanDataBlock(obj.stringValue);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
