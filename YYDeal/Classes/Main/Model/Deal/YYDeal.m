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

- (BOOL)isEqual:(YYDeal *)other
{
    return [self.deal_id isEqualToString:other.deal_id];
}

- (void)setCurrent_price:(NSNumber *)current_price
{
    _current_price = [self dealNumber:current_price];
}

- (void)setList_price:(NSNumber *)list_price
{
    _list_price = [self dealNumber:list_price];
}

#pragma mark - 处理价格小数
- (NSNumber *)dealNumber:(NSNumber *)sourceNumber
{
    NSString *str = [sourceNumber description];
    //小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2)// 小数超过两位
    {
        str = [str substringToIndex:dotIndex + 3];
    }
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    return [fmt numberFromString:str];
}

// 遵守codeing协议
MJCodingImplementation
@end
