//
//  YYcategoriesViewController.m
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCategoriesViewController.h"
#import "YYDropDownView.h"
@interface YYCategoriesViewController ()

@end

@implementation YYCategoriesViewController

- (void)loadView
{
    self.view = [YYDropDownView menu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = self.view.size;
    
}

@end
