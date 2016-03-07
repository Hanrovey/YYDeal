//
//  YYFindDealsResult.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/5.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYFindDealsResult : NSObject

/** 所有页面团购总数 */
@property (assign, nonatomic) int total_count;
/** 本次API访问所获取的单页团购数量 */
@property (assign, nonatomic) int count;
/** 所有的团购 */
@property (strong, nonatomic) NSArray *deals;

@end
