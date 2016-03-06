//
//  YYSort.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先 */
typedef enum {
    YYSortValueDefault = 1, // 默认排序
    YYSortValueLowPrice, // 价格最低
    YYSortValueHighPrice, // 价格最高
    YYSortValuePopular, // 人气最高
    YYSortValueLatest, // 最新发布
    YYSortValueOver, // 即将结束
    YYSortValueClosest // 离我最近
} YYSortValue;

@interface YYSort : NSObject
@property (assign, nonatomic) int value;
@property (copy, nonatomic) NSString *label;
@end
