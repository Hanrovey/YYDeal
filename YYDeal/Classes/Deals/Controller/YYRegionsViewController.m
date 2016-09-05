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
#import "YYRegion.h"
#import "YYCitiesViewController.h"
@interface YYRegionsViewController ()<YYDropDownViewDelegate>
- (IBAction)changeCity:(UIButton *)sender;
@property(nonatomic,weak) YYDropDownView *dropView;
@end

@implementation YYRegionsViewController

- (YYDropDownView *)dropView
{
    if (_dropView == nil) {
        // 顶部View
        UIView *topView = [self.view.subviews firstObject];
        
        //菜单View
        YYDropDownView *dropView = [YYDropDownView menu];
        dropView.delegate = self;
        [self.view addSubview:dropView];

        // menu的ALEdgeTop == topView的ALEdgeBottom
        [dropView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView];
        // 除开顶部，其他方向距离父控件的间距都为0
        [dropView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        
        self.dropView = dropView;
    }
    return _dropView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.preferredContentSize = CGSizeMake(300, 480);

}

#pragma mark - 公共方法
- (void)setRegions:(NSArray *)regions
{
    _regions = regions;
    
    self.dropView.items = regions;
}

- (void)setSelectedRegion:(YYRegion *)selectedRegion
{
    _selectedRegion = selectedRegion;
    
    int mainRow = [self.dropView.items indexOfObject:selectedRegion];
    [self.dropView selectMain:mainRow];
}

- (void)setSelectedSubRegionName:(NSString *)selectedSubRegionName
{
    _selectedSubRegionName = [selectedSubRegionName copy];
    
    int subRow = [self.selectedRegion.subregions indexOfObject:selectedSubRegionName];
    [self.dropView selectSub:subRow];
}

- (IBAction)changeCity:(UIButton *)sender
{
    // 1.关闭所在的popover(利用KVC可以访问任何属性和成员变量)
//    UIPopoverController *popover = [self valueForKeyPath:@"popoverController"];
//    [popover dismissPopoverAnimated:YES];
    
    
    // 1.弹出城市列表
    YYCitiesViewController *cityVC = [[YYCitiesViewController alloc] init];
    cityVC.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:cityVC animated:YES completion:nil];
    
    // 2.关闭popover
    //    UIPopoverController *popover = [self valueForKeyPath:@"_popoverController"];
    //    [popover dismissPopoverAnimated:YES];
//    if (self.changeCityBlock)
//    {
//        self.changeCityBlock();
//        
//        NSLog(@"%@",self.changeCityBlock);
//    }
}

#pragma mark - YYDropDownViewDelegate
- (void)dropDownView:(YYDropDownView *)dropDownView didSelectMain:(int)mainRow
{
    YYRegion *r = dropDownView.items[mainRow];
    if (r.subregions.count == 0)
    {
        // 发出通知，选中了某个区域
        [YYNotificationCenter postNotificationName:YYRegionDidSelectNotification object:nil userInfo:@{YYSelectedRegion : r}];
    }else
    {
        if (self.selectedRegion == r)
        {
            // 选中右边的子类别
            self.selectedSubRegionName = self.selectedSubRegionName;
        }
    }
}

- (void)dropDownView:(YYDropDownView *)dropDownView didSelectSub:(int)subRow ofMain:(int)mainRow
{
    // 发出通知，选中了某个区域
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    YYRegion *r = dropDownView.items[mainRow];
    userInfo[YYSelectedRegion] = r;
    userInfo[YYSelectedSubRegionName] = r.subregions[subRow];
    [YYNotificationCenter postNotificationName:YYRegionDidSelectNotification object:nil userInfo:userInfo];
}
@end
