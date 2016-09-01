//
//  YYDropDownViewMainCell.h
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/8/22.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDropDownView.h"
@interface YYDropDownViewMainCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic, strong) id<YYDropDownViewItem> item;
@end
