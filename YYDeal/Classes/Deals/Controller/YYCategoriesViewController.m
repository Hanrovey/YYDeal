//
//  YYcategoriesViewController.m
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCategoriesViewController.h"
#import "YYDropDownView.h"
#import "YYCategory.h"
@interface YYCategoriesViewController ()<YYDropDownViewDelegate>
@property (nonatomic ,weak) YYDropDownView *dropDownView;
@end

@implementation YYCategoriesViewController

- (void)loadView
{
    YYDropDownView *dropDownView = [YYDropDownView menu];
    dropDownView.delegate = self;
    dropDownView.items = [YYMetaDataTool sharedMetaDataTool].categories;
    self.view = dropDownView;
    self.dropDownView = dropDownView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(400, 480);
    
}

#pragma mark - YYDropDownViewDelegate
- (void)dropDownView:(YYDropDownView *)dropDownView didSelectMain:(int)mainRow
{
    YYCategory *c = dropDownView.items[mainRow];
    if (c.subcategories.count == 0)
    {
        // 发出通知，选中了某个分类
        [YYNotificationCenter postNotificationName:YYCategoryDidSelectNotification object:nil userInfo:@{YYSelectedCategory : c}];
    }else
    {
        if (self.selectedCategory == c)
        {
            // 选中右边的子类别
            self.selectedSubCategoryName = self.selectedSubCategoryName;
        }
    }
}

- (void)dropDownView:(YYDropDownView *)dropDownView didSelectSub:(int)subRow ofMain:(int)mainRow
{
    // 发出通知，选中了某个分类
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    YYCategory *c = dropDownView.items[mainRow];
    userInfo[YYSelectedCategory] = c;
    userInfo[YYSelectedSubCategoryName] = c.subcategories[subRow];
    [YYNotificationCenter postNotificationName:YYCategoryDidSelectNotification object:nil userInfo:userInfo];
}

#pragma mark - 公共方法
- (void)setSelectedCategory:(YYCategory *)selectedCategory
{
    _selectedCategory = selectedCategory;
    
    int mainRow = [self.dropDownView.items indexOfObject:selectedCategory];
    [self.dropDownView selectMain:mainRow];
}

- (void)setSelectedSubCategoryName:(NSString *)selectedSubCategoryName
{
    _selectedSubCategoryName = [selectedSubCategoryName copy];
    
    int subRow = [self.selectedCategory.subcategories indexOfObject:selectedSubCategoryName];
    [self.dropDownView selectSub:subRow];
}
@end
