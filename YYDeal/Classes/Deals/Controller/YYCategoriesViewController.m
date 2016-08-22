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
    YYDropDownView *menu = [YYDropDownView menu];
    menu.items = [YYMetaDataTool sharedMetaDataTool].categories;
    self.view = menu;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(325, 480);
    
}

@end
