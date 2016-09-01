//
//  YYRegionsViewController.h
//  YYDeal
//
//  Created by ihefe on 16/3/10.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYRegion;
@interface YYRegionsViewController : UIViewController

@property (nonatomic, strong) NSArray *regions;
/** 当前选中的分类 */
@property (strong, nonatomic) YYRegion *selectedRegion;
/** 当前选中的子分类名称 */
@property (copy, nonatomic) NSString *selectedSubRegionName;
@end
