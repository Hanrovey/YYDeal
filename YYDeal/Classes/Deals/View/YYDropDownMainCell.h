//
//  YYDropDownMainCell.h
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/8/22.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDropDownView.m"
@interface YYDropDownMainCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong) id<YYDropDownViewItem> item;
@end
