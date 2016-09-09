//
//  YYDealCell.h
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDeal, YYDealCell;

@protocol YYDealCellDelegate <NSObject>

@optional
- (void)dealCellDidClickCover:(YYDealCell *)dealCell;

@end

@interface YYDealCell : UICollectionViewCell
@property (nonatomic, strong) YYDeal *deal;

@property (nonatomic, weak) id<YYDealCellDelegate> delegate;
@end
