//
//  YYDealDetailController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealDetailController.h"
#import "YYDeal.h"
@interface YYDealDetailController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView *loadingView;
@end

@implementation YYDealDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置背景
    self.view.backgroundColor = YYGlobalBg;
    self.webView.backgroundColor = YYGlobalBg;
    
    // 加载网页
    NSURL *url = [NSURL URLWithString:self.deal.deal_h5_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.scrollView.hidden = YES;
    [self.webView loadRequest:request];
    
    
    // 圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.webView addSubview:loadingView];
    [loadingView startAnimating];
    // 居中
    [loadingView autoCenterInSuperview];
    self.loadingView = loadingView;
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 拼接详情的URL路径
    NSString *ID = self.deal.deal_id;
    ID = [ID substringFromIndex:[ID rangeOfString:@"-"].location + 1];
    NSString *urlStr = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];

    
    if ([webView.request.URL.absoluteString isEqualToString:urlStr]) {// 加载详情页面完毕
        NSMutableString *js = [NSMutableString string];
        [js appendString:@"var bodyHTML = '';"];
        // 拼接link的内容
        [js appendString:@"var link = document.body.getElementsByTagName('link')[0];"];
        [js appendString:@"bodyHTML += link.outerHTML;"];
        // 拼接多个div的内容
        [js appendString:@"var divs = document.getElementsByClassName('detail-info');"];
        [js appendString:@"for (var i = 0; i<=divs.length; i++) {"];
        [js appendString:@"var div = divs[i];"];
        [js appendString:@"if (div) { bodyHTML += div.outerHTML; }"];
        [js appendString:@"}"];
        // 设置body的内容
        [js appendString:@"document.body.innerHTML = bodyHTML;"];
        
        // 执行JS代码
        [webView stringByEvaluatingJavaScriptFromString:js];
        
        // 显示网页内容
        webView.scrollView.hidden = NO;
        // 移除圈圈
        [self.loadingView removeFromSuperview];
    }else
    {   // 加载初始网页完毕 记得 url用 ‘’ 修饰
        NSString *js = [NSString stringWithFormat:@"window.location.href = '%@';", urlStr];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
    
}
@end
