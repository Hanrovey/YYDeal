//
//  YYRegionsViewController.m
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYRegionsViewController.h"
#import "YYDropDownView.h"
@interface YYRegionsViewController ()

@end

@implementation YYRegionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 顶部View
    UIView *topView = [self.view.subviews firstObject];
    
    //菜单View
    YYDropDownView *dropView = [YYDropDownView menu];
    [self.view addSubview:dropView];
    
    // menu的ALEdgeTop == topView的ALEdgeBottom
    [dropView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView];
    // 除开顶部，其他方向距离父控件的间距都为0
    [dropView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
}

@end
