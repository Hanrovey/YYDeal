//
//  YYcategoriesViewController.h
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYCategory;
@interface YYCategoriesViewController : UIViewController
/** 当前选中的分类 */
@property (strong, nonatomic) YYCategory *selectedCategory;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubCategoryName;
@end
