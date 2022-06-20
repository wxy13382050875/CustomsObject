//
//  CenterTabViewController.m
//  XW_Customs_Ios
//
//  Created by 武新义 on 2022/6/15.
//

#import "CenterTabViewController.h"
#import "WebViewJavascriptBridge.h"
#import "xw_HomeViewModel.h"
#import "xw_OrgDetailModel.h"
@interface CenterTabViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView* webView;
@property(nonatomic,strong)WKWebViewConfiguration *config;
@property(nonatomic,strong)WebViewJavascriptBridge* bridge;
@property (nonatomic, assign) BOOL isDataLoaded;
/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;
@property (nonatomic, strong) xw_HomeViewModel *viewModel;
@end

@implementation CenterTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)loadDataForFirst {
    //第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        self.isDataLoaded = YES;
        [self getData];
    }
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}
-(void)listDidAppear{
    [self loadDataForFirst];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)xw_bindViewModel{
}
-(void)xw_setupUI{
    [self.view addSubview:self.webView];
    
    self.webView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(5, 0, 0, 0)) ;
    [self.view addSubview:self.myProgressView];
    self.myProgressView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(2);
}
-(void)xw_layoutNavigation{
    if([self.type isEqualToString:@"tab"]){
        [self.navigationController.navigationBar xw_setBackgroundColor:COLOR(@"#206EEA")];
    } else {
        [self.navigationController.navigationBar xw_setBackgroundColor:COLOR(@"##ffffff")];
    }
    
}
-(void)xw_loadDataSource{
    [self getData];
    
}
-(void)getData{
//    [self.view showLoadingMeg:@"正在加载"];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:self.orgId forKey:@"orgId"];
    [[self.viewModel.getOrgDetailByIdCommand execute: params] subscribeNext:^(id x) {
//                    GGLog(@"刷新");
//        [self.view hideLoading];
        xw_OrgDetailModel* model = [xw_OrgDetailModel mj_objectWithKeyValues:x[@"data"]];
        NSString* html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title><style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style></head><body><div class=content>%@</div></body></html>",model.introduce];
        
        
        [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
        self.title = model.name;

    } error:^(NSError *error) {
//        Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
    }];
}

#pragma mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidStartLoad");
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webViewDidFinishLoad");
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"webViewWebContentProcessDidTerminate");
    exit(0);
}
#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// 记得取消监听
- (void)dealloc
{
    @try {
        [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    } @catch (NSException *e) { }
      self.webView = nil;
    
}
#pragma mark 懒加载
-(WKWebView*)webView{

    if (!_webView) {
        //初始化
         _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:self.config];
          // UI代理
         _webView.UIDelegate = self;
          // 导航代理
         _webView.navigationDelegate = self;

         _webView.opaque = NO;
         _webView.multipleTouchEnabled = NO;
        _webView.backgroundColor = [UIColor whiteColor];
         
    }
    return _webView;
}
-(WKWebViewConfiguration*)config{
 
    if (!_config) {
        //配置环境
        _config = [[WKWebViewConfiguration alloc]init];
        
        // 创建设置对象
         WKPreferences *preference = [[WKPreferences alloc]init];
         //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
         preference.minimumFontSize = 0;
         //设置是否支持javaScript 默认是支持的
         preference.javaScriptEnabled = NO;
         // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
         preference.javaScriptCanOpenWindowsAutomatically = NO;
         _config.preferences = preference;

         // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
         _config.allowsInlineMediaPlayback = YES;
         //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
         _config.requiresUserActionForMediaPlayback = YES;
         //设置是否允许画中画技术 在特定设备上有效
         _config.allowsPictureInPictureMediaPlayback = YES;
         //设置请求的User-Agent信息中应用程序名称 iOS9后可用
         _config.applicationNameForUserAgent = @"ChinaDailyForiPad";
          //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
        
//         WKScriptMessageHandler *weakScriptMessageDelegate = [[WKScriptMessageHandler alloc] initWithDelegate:self];
//         //这个类主要用来做native与JavaScript的交互管理
//         WKUserContentController * wkUController = [[WKUserContentController alloc] init];
//         //注册一个name为jsToOcNoPrams的js方法
//         [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcNoPrams"];
//         [wkUController addScriptMessageHandler:weakScriptMessageDelegate  name:@"jsToOcWithPrams"];
//        _config.userContentController = wkUController;
    }
    return _config;
}
-(WebViewJavascriptBridge*)bridge{
 
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
        
//        [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
//            NSLog(@"testObjcCallback called: %@", data);
//            responseCallback(@"Response from testObjcCallback");
//        }];
//
//        [_bridge callHandler:@"testJavascriptHandler" data:@{ @"foo":@"before ready" }];
    }
    return _bridge;
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
        _myProgressView = [UIProgressView new];
        _myProgressView.tintColor = [UIColor blueColor];
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
}
- (xw_HomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[xw_HomeViewModel alloc] init];
    }
    return _viewModel;
}
@end
