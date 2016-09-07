//
//  YYGetSingleDealResult.h
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/7.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYGetSingleDealResult : NSObject

/** 本次API访问所获取的单页团购数量 */
@property (assign, nonatomic) int count;
/** 所有的团购 */
@property (strong, nonatomic) NSArray *deals;
@end
