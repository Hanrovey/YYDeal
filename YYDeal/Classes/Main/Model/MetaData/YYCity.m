
//
//  YYCity.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCity.h"
#import "YYRegion.h"
@implementation YYCity
- (NSDictionary *)objectClassInArray
{
    return @{@"regions" : [YYRegion class]};
}
@end
