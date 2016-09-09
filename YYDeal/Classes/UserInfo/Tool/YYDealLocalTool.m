
//
//  YYDealLocalTool.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealLocalTool.h"
#define YYHistoryDealsFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history_deals.data"]

@interface YYDealLocalTool()
{
    NSMutableArray *_historyDeals;
}
@end

@implementation YYDealLocalTool
YYSingletonM(DealLocalTool)

- (NSMutableArray *)historyDeals
{
    if (!_historyDeals) {
        _historyDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:YYHistoryDealsFile];
        
        if (!_historyDeals) {
            _historyDeals = [NSMutableArray array];
        }
    }
    
    return _historyDeals;
}

- (void)saveHistoryDeal:(YYDeal *)deal
{
    [self.historyDeals addObject:deal];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.historyDeals toFile:YYHistoryDealsFile];
}
@end
