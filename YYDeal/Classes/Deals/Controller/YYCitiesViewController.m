//
//  YYCitiesViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/8/23.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCitiesViewController.h"
#import "YYCityGroup.h"
#import "YYCitySearchViewController.h"
@interface YYCitiesViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)close:(id)sender;
/** 导航栏顶部的间距约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)coverClick:(UIButton *)sender;

/** 城市组数据 */
@property (strong, nonatomic) NSArray *cityGroups;
/** 城市搜索结果界面 */
@property (nonatomic, strong) YYCitySearchViewController *citySearchVc;
@end

@implementation YYCitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 懒加载
- (YYCitySearchViewController *)citySearchVc
{
    if (!_citySearchVc) {
        self.citySearchVc = [[YYCitySearchViewController alloc] init];
    }
    return _citySearchVc;
}

- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        self.cityGroups = [YYMetaDataTool sharedMetaDataTool].cityGroups;
    }
    return _cityGroups;
}

#pragma mark - UISearchBarDelegate
/** 搜索框结束编辑（退出键盘） */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 更换背景
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    // 隐藏取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    // 让整体向下挪动
    self.topConstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢消失
        self.cover.alpha = 0.0;
    }];
    
}

/** 搜索框开始编辑（弹出键盘） */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 更换背景
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    // 显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    // 让整体向上挪动
    self.topConstraint.constant = -62;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出来
        self.cover.alpha = 0.6;
    }];
}

/** 点击了取消 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}

/** 搜索框的文字发生改变的时候调用 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.citySearchVc.view removeFromSuperview];
    if (searchText.length > 0) {
        [self.view addSubview:self.citySearchVc.view];
        
        [self.citySearchVc.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.citySearchVc.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:searchBar];
    }
}

#pragma mark - 让控制器在formSheet情况下也能正常退出键盘
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYCityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YYCityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YYCityGroup *group = self.cityGroups[section];
    return group.title;
}

// Shift + Control + 单击 == 查看在xib\storyboard中重叠的所有UI控件
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // 将cityGroups数组中所有元素的title属性值取出来，放到一个新的数组
    return [self.cityGroups valueForKeyPath:@"title"];
}


- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)coverClick:(UIButton *)sender
{
    [self.view endEditing:YES];

}


@end
