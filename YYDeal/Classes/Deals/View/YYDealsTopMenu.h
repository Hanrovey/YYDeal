//
//  YYDealsTopMenu.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//  团购列表顶部菜单

#import <UIKit/UIKit.h>

@interface YYDealsTopMenu : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLable;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

/**
 *  快速创建View
 */
+ (instancetype)menu;

- (void)addTarget:(id)target action:(SEL)action;
@end
