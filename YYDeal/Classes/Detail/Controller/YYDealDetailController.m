//
//  YYDealDetailController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealDetailController.h"
#import "YYDeal.h"
#import "YYRestriction.h"
#import "YYCenterLineLable.h"
#import "YYDealTool.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "YYDealLocalTool.h"
@interface YYDealDetailController ()<UIWebViewDelegate>
- (IBAction)back;
- (IBAction)buy;
- (IBAction)collect;
- (IBAction)share;
// label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet YYCenterLineLable *listPriceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


// 按钮
@property (weak, nonatomic) IBOutlet UIButton *refundableAnyTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *refundableExpiresButton;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCountButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

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
    
    // 存储浏览记录
    [[YYDealLocalTool sharedDealLocalTool] saveHistoryDeal:self.deal];
    
    // 判断是否收藏
    NSArray *collectArray = [YYDealLocalTool sharedDealLocalTool].collectDeals;
    self.collectButton.selected = [collectArray containsObject:self.deal];
    
    // 设置左边的内容
    [self setupLeftContent];
    
    // 设置右边的内容
    [self setupRightContent];
    
}


/**
 *  设置右边的内容
 */
- (void)setupRightContent
{
    // 加载网页
    NSURL *url = [NSURL URLWithString:self.deal.deal_h5_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
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

/**
 *  设置左边的内容
 */
- (void)setupLeftContent
{
    // 更新左边内容
    [self updateLeftContent];
    
    // 加载更详细的团购数据
    YYGetSingleDealParam *param = [[YYGetSingleDealParam alloc] init];
    param.deal_id = self.deal.deal_id;
    [YYDealTool getSingleDeal:param success:^(YYGetSingleDealResult *result) {
        if (result.deals.count) {
            self.deal = [result.deals lastObject];
            // 更新左边的内容
            [self updateLeftContent];
        } else {
            [MBProgressHUD showError:@"没有找到指定的团购信息"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载团购数据失败"];
    }];
    
}

/**
 *  更新左边的内容
 */
- (void)updateLeftContent
{
    // 简单信息
    self.titleLabel.text = self.deal.title;
    self.descLabel.text = self.deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.deal.current_price];
    self.listPriceLabel.text = [NSString stringWithFormat:@"门店价￥%@", self.deal.list_price];
    self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    self.refundableExpiresButton.selected = self.deal.restrictions.is_refundable;
    self.purchaseCountButton.title = [NSString stringWithFormat:@"已售出%d", self.deal.purchase_count];
    
    // 图片
    [self.iconView setImageWithURL:[NSURL URLWithString:self.deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    // 剩余处理时间
    // 当前时间 2014-08-27 09:00
    NSDate *now = [NSDate date];
    // 过期时间 2014-08-24 00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *deadTime = [[fmt dateFromString:self.deal.purchase_deadline] dateByAddingTimeInterval:24 * 3600];
    // 比较俩个时间差距
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *componet = [calender components:unit fromDate:now toDate:deadTime options:0];
    if (componet.day > 365) {
        self.leftTimeButton.title = @"一年内不过期";
    }else
    {
        self.leftTimeButton.title = [NSString stringWithFormat:@"%ld天%ld时%ld分",(long)componet.day,(long)componet.hour,(long)componet.minute];
    }
}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 拼接详情的URL路径
    NSString *ID = self.deal.deal_id;
    ID = [ID substringFromIndex:[ID rangeOfString:@"-"].location + 1];
    NSString *urlStr = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
    
    if (![webView.request.URL.absoluteString isEqualToString:urlStr]) { // 加载详情页面完毕
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
        
        
    } else { // 加载初始网页完毕
        NSString *js = [NSString stringWithFormat:@"window.location.href = '%@';", urlStr];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
}

#pragma mark - 按钮处理
- (IBAction)buy {
}

- (IBAction)collect
{
    if (self.collectButton.selected)
    {
        [[YYDealLocalTool sharedDealLocalTool] unsaveCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"取消收藏成功"];
    }else
    {
        [[YYDealLocalTool sharedDealLocalTool] saveCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"收藏成功"];
    }
    
    self.collectButton.selected = !self.collectButton.isSelected;
}

- (IBAction)share {
    
    NSString *text = [NSString stringWithFormat:@"【%@】%@ 详情查看：%@", self.deal.title, self.deal.desc, self.deal.deal_url];
    
    // 需要分享的图片（不分享占位图片）
    UIImage *image = nil;
    if (self.iconView.image != [UIImage imageNamed:@"placeholder_deal"]) {
        image = self.iconView.image;
    }
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMAppKey shareText:text shareImage:image shareToSnsNames:@[UMShareToSina, UMShareToQQ] delegate:nil];
}


- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
