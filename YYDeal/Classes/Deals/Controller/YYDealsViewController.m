//
//  YYDealsViewController.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealsViewController.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"
@interface YYDealsViewController ()<AwesomeMenuDelegate>

@end

@implementation YYDealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 用户菜单
    [self setupUserMenu];
    
}

/**
 *  创建一个path菜单item
 */
- (AwesomeMenuItem *)itemWithContent:(NSString *)content highlightedContent:(NSString *)highlightedContent
{
    UIImage *itemBg = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
    return [[AwesomeMenuItem alloc] initWithImage:itemBg highlightedImage:nil ContentImage:[UIImage imageNamed:content] highlightedContentImage:[UIImage imageNamed:highlightedContent]];
}

/**
 *  用户菜单
 */
- (void)setupUserMenu
{
    // 1.周边的item
    AwesomeMenuItem *mineItem = [self itemWithContent:@"icon_pathMenu_mine_normal" highlightedContent:@"icon_pathMenu_mine_highlighted"];
    AwesomeMenuItem *collectItem = [self itemWithContent:@"icon_pathMenu_collect_normal" highlightedContent:@"icon_pathMenu_collect_highlighted"];
    AwesomeMenuItem *scanItem = [self itemWithContent:@"icon_pathMenu_scan_normal" highlightedContent:@"icon_pathMenu_scan_highlighted"];
    AwesomeMenuItem *moreItem = [self itemWithContent:@"icon_pathMenu_more_normal" highlightedContent:@"icon_pathMenu_more_highlighted"];
    NSArray *items = @[mineItem, collectItem, scanItem, moreItem];

    // 2.中间的开始item
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc]initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"] highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"] ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"] highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectZero startItem:startItem optionMenus:items];
    [self.view addSubview:menu];
    // 整个菜单的活动范围
    menu.menuWholeAngle = M_PI_2;
    
    //约束
    CGFloat menuH = 200;
    [menu autoSetDimensionsToSize:CGSizeMake(200, menuH)];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];

    // 3.添加一个背景
    UIImageView *menuBg = [[UIImageView alloc] init];
    menuBg.image = [UIImage imageNamed:@"icon_pathMenu_background"];
    [menu insertSubview:menuBg atIndex:0];
    // 约束
    [menuBg autoSetDimensionsToSize:menuBg.image.size];
    [menuBg autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menuBg autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    // 起点
    menu.startPoint = CGPointMake(menuBg.image.size.width * 0.5, menuH - menuBg.image.size.height * 0.5);
    // 禁止中间按钮旋转
    menu.rotateAddButton = NO;
    
    // 设置代理
    menu.delegate = self;
}

#pragma mark - 菜单代理
- (void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu
{
    // 显示xx图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
    // 恢复图片
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];

}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    [self awesomeMenuWillAnimateClose:menu];
}

























@end
