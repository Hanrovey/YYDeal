//
//  YYCityGroup.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCityGroup : NSObject
/** 组标题 */
@property (copy, nonatomic) NSString *title;
/** 这组显示的城市 */
@property (strong, nonatomic) NSArray *cities;
@end
