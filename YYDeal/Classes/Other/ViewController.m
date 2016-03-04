//
//  ViewController.m
//  YYDeal(HD)
//
//  Created by ihefe-0004 on 16/3/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "ViewController.h"
#import "YYDealTool.h"
#import "YYFindDealsParam.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YYFindDealsParam *param = [[YYFindDealsParam alloc] init];
    param.city = @"上海";
    
    [YYDealTool findDeals:param success:^(YYFindDealsResult *result) {
        
        NSLog(@"succ-----%@",result.deals);
        
    } failure:^(NSError *error) {
        NSLog(@"err----%@",error);
    }];
    
}

@end
