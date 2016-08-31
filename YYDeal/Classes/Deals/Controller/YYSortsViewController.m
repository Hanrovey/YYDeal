//
//  YYSortsViewController.m
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYSortsViewController.h"
#import "YYSort.h"

#pragma mark - 自定义Button
@interface YYSortButton  : UIButton
@property (strong, nonatomic) YYSort *sort;
@end

@implementation YYSortButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bgImage = @"btn_filter_normal";
        self.selectedBgImage = @"btn_filter_selected";
        self.titleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSort:(YYSort *)sort
{
    _sort = sort;
    self.title = sort.label;
}
@end


#pragma mark - 控制器代码
@interface YYSortsViewController ()
@property (weak, nonatomic) YYSortButton *selectedButton;
@end

@implementation YYSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置在popover中的尺寸
    self.preferredContentSize = self.view.size;
    
    
    // 根据排序模型额个数，创建对应的按钮
    CGFloat buttonX = 20;
    CGFloat buttonW = self.view.width - 2 *buttonX;
    CGFloat buttonP = 15;
    CGFloat contentH = 0;
    
    NSArray *sorts = [YYMetaDataTool sharedMetaDataTool].sorts;
    
    for (int i = 0; i < sorts.count; i++) {
        
        //创建按钮
        YYSortButton *button = [[YYSortButton alloc] init];
        //取出模型
        button.sort = sorts[i];
        
        // 设置尺寸
        button.x = buttonX;
        button.width = buttonW;
        button.height = 30;
        button.y = buttonP + i *(button.height + buttonP);
        
        // 监听按钮点击
        [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        
        
        //内容高度
        contentH = button.maxY + buttonP;
    }
    
    
    // 设置contentSize
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentSize = CGSizeMake(0, contentH);
    
}


- (void)sortButtonClick:(YYSortButton *)button
{
    // 1.修改状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.发出通知
    [YYNotificationCenter postNotificationName:YYSortDidSelectNotification object:nil userInfo:@{YYSelectedSort : button.sort}];
}
@end
