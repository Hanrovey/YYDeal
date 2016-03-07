//
//  YYDeal.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/5.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDeal.h"
#import "YYBusiness.h"
@implementation YYDeal

- (NSDictionary *)objectClassInArray
{
    return @{@"businesses" : [YYBusiness class]};
}

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}
@end
