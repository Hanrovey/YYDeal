//
//  YYGetSingleDealResult.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/7.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYGetSingleDealResult.h"
#import "YYDeal.h"
@implementation YYGetSingleDealResult
- (NSDictionary *)objectClassInArray
{
    return @{@"deals" : [YYDeal class]};
}
@end
