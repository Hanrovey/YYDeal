//
//  YYFindDealsResult.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/5.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYFindDealsResult.h"
#import "YYDeal.h"
@implementation YYFindDealsResult

- (NSDictionary *)objectClassInArray
{
    return @{@"deals" : [YYDeal class]};
}
@end
