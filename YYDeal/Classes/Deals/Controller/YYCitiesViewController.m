//
//  YYCitiesViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/8/23.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCitiesViewController.h"

@interface YYCitiesViewController ()<UISearchBarDelegate>
- (IBAction)close:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)coverClick:(UIButton *)sender;
@end

@implementation YYCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - 让控制器在formSheet情况下也能正常退出键盘
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
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
