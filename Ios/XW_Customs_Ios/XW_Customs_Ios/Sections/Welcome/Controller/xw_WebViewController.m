//
//  xw_WebViewController.m
//  XW_Object
//
//  Created by Benc Mai on 2020/4/28.
//  Copyright © 2020 武新义. All rights reserved.
//

#import "xw_WebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "xw_WebViewModel.h"
#import "xw_WebModel.h"
@interface xw_WebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView* webView;
@property(nonatomic,strong)WKWebViewConfiguration *config;
@property(nonatomic,strong)WebViewJavascriptBridge* bridge;
@property(nonatomic,strong)xw_WebViewModel *viewModel;

/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;
@end

@implementation xw_WebViewController

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
-(void)xw_bindViewModel{
}
-(void)xw_setupUI{
    [self.view addSubview:self.webView];
    
    self.webView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0)) ;
    [self.view addSubview:self.myProgressView];
    self.myProgressView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(2);
}
-(void)xw_layoutNavigation{
}
-(void)xw_loadDataSource{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if ([self.type isEqualToString:@"protocol"]) {
            [self GetProtocolDetail];
        } else if ([self.type isEqualToString:@"noAuth"]) {
            [self GetProtocolDetailNoAuth];
        } else {
            [self GetArticleDetail];
        }
        
            
    });
}
-(void)GetProtocolDetail{
    self.viewModel.contentId = self.contentId;
            [self.view showLoadingMeg:@"正在加载"];
            [[self.viewModel.requestProtocolsCommand execute: nil] subscribeNext:^(id x) {
//                    GGLog(@"刷新");
                [self.view hideLoading];
                
                NSString* html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title><style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style></head><body><div class=content>%@</div></body></html>",x[@"data"][@"contents"]];
                
                
                [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
                self.title = x[@"data"][@"name"];

            } error:^(NSError *error) {
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
            }];
}
-(void)GetProtocolDetailNoAuth{
    self.viewModel.contentId = self.contentId;
            [self.view showLoadingMeg:@"正在加载"];
            [[self.viewModel.requestProtocolsCommandNoAuth execute: nil] subscribeNext:^(id x) {
//                    GGLog(@"刷新");
                [self.view hideLoading];
                
                NSString* html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title><style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style></head><body><div class=content>%@</div></body></html>",x[@"data"][@"contents"]];
                
                
                [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
                self.title = x[@"data"][@"name"];

            } error:^(NSError *error) {
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
            }];
}

-(void)GetArticleDetail{
    self.viewModel.contentId = self.contentId;
            self.viewModel.type = self.type;
            [self.view showLoadingMeg:@"正在加载"];
            [[self.viewModel.requestCommand execute: nil] subscribeNext:^(id x) {
//                    GGLog(@"刷新");
                [self.view hideLoading];
                
                xw_WebModel* tmModel = [xw_WebModel mj_objectWithKeyValues:x[@"data"]];
    //            webBean = rs.getData();
                if (tmModel.type != nil && (tmModel.url != nil || tmModel.content != nil)){
                    if ([tmModel.type isEqualToString:@"SKIP"]){
    //                    webView.loadUrl(webBean.getUrl());//加载url
                        NSURL *url = [NSURL URLWithString:tmModel.url];
                        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
                        [self.webView loadRequest:request];
                    } else {
    //                    webView.loadDataWithBaseURL(null, webBean.getContent(), "text/html", "UTF-8", null);
                        
                        NSString* html = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=viewport content=\"width=device-width,minimum-scale=1,maximum-scale=1,user-scalable=no,initial-scale=1\"><title></title><style>html,body,h1,h2,h3,h4,h5,ul{margin:0}h4 strong { text-align: left; display: inline-block; }html,body{width:100%%;padding:0;margin:0}body{overflow-y:scroll}img{max-width:100%%}.content{padding:0 10px;word-wrap: break-word; word-break: normal;word-break:break-all;}.content p{overflow:visible;letter-spacing:.2px;line-height:32px}</style></head><body><div class=content>%@</div></body></html>",tmModel.content];
                        
                        
                        [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
                    }
                }
                self.title = tmModel.title;

            } error:^(NSError *error) {
                Dialog().wTypeSet(DialogTypeAuto).wMessageSet(error.localizedDescription).wDisappelSecondSet(1).wStart();
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
-(xw_WebViewModel*)viewModel{
    if (!_viewModel) {
        _viewModel = [[xw_WebViewModel alloc] init];
    }
    return _viewModel;
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

@end
