//
//  YYSearchViewController.h
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 2016/10/25.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealListViewController.h"
@class YYCity;
@interface YYSearchViewController : YYDealListViewController
/** 选中的状态 */
@property (nonatomic, strong) YYCity *selectedCity;
@end
