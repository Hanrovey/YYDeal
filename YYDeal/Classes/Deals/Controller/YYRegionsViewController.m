//
//  YYRegionsViewController.m
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYRegionsViewController.h"
#import "YYDropDownView.h"
#import "YYCity.h"
#import "YYCitiesViewController.h"
@interface YYRegionsViewController ()
- (IBAction)changeCity:(UIButton *)sender;
@end

@implementation YYRegionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 顶部View
    UIView *topView = [self.view.subviews firstObject];
    
    //菜单View
    YYDropDownView *dropView = [YYDropDownView menu];
    
#warning 临时的假数据
//    YYMetaDataTool *tool = [YYMetaDataTool sharedMetaDataTool];
//    YYCity *city = [tool cityWithName:@"广州"];
//    dropView.items = city.regions;
    
    [self.view addSubview:dropView];
    
    
    // menu的ALEdgeTop == topView的ALEdgeBottom
    [dropView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView];
    // 除开顶部，其他方向距离父控件的间距都为0
    [dropView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];

    self.preferredContentSize = CGSizeMake(300, 480);

}



- (IBAction)changeCity:(UIButton *)sender
{
    // 1.关闭popover
    UIPopoverController *popover = [self valueForKeyPath:@"_popoverController"];
    [popover dismissPopoverAnimated:YES];
    
    // 2.弹出城市列表
    YYCitiesViewController *cityVC = [[YYCitiesViewController alloc] init];
    cityVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:cityVC animated:YES completion:nil];
}
@end
