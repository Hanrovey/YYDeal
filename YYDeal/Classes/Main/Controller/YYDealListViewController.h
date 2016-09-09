//
//  YYDealListViewController.h
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDealListViewController : UICollectionViewController
/** 存放所有的团购数据 */
@property (nonatomic, strong) NSMutableArray *deals;

- (NSString *)emptyIcon;
@end
