//
//  YYDropDownView.h
//  YYDeal
//
//  Created by ihefe_Hanrovey on 16/5/13.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YYDropDownViewItem <NSObject>
@required
/** 标题 */
- (NSString *)title;
/** 子标题数据 */
- (NSArray *)subtitles;
@optional
/** 图标 */
- (NSString *)image;
/** 选中的图标 */
- (NSString *)highlightedImage;
@end


@interface YYDropDownView : UIView
+ (instancetype)menu;

/**
 *  显示的数据模型(里面的模型必须遵守YYDropDownViewItem协议)
 */
@property (nonatomic, strong) NSArray *items;
@end
