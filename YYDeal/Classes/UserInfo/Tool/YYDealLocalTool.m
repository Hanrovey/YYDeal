
//
//  YYDealLocalTool.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealLocalTool.h"
#define YYHistoryDealsFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history_deals.data"]

#define YYCollectDealsFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collect_deals.data"]
@interface YYDealLocalTool()
{
    NSMutableArray *_historyDeals;
    NSMutableArray *_collectDeals;
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
    [self.historyDeals removeObject:deal];
    [self.historyDeals insertObject:deal atIndex:0];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.historyDeals toFile:YYHistoryDealsFile];
}

- (void)unsaveHistoryDeal:(YYDeal *)deal
{
    [self.historyDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:self.historyDeals toFile:YYHistoryDealsFile];

}

- (void)unsaveHistoryDeals:(NSArray *)deals
{
    [self.historyDeals removeObjectsInArray:deals];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.historyDeals toFile:YYHistoryDealsFile];
}

- (NSMutableArray *)collectDeals
{
    if (!_collectDeals) {
        _collectDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:YYCollectDealsFile];
        
        if (!_collectDeals) {
            _collectDeals = [NSMutableArray array];
        }
    }
    
    return _collectDeals;
}

- (void)saveCollectDeal:(YYDeal *)deal
{
    
    [self.collectDeals removeObject:deal];
    [self.collectDeals insertObject:deal atIndex:0];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.collectDeals toFile:YYCollectDealsFile];
}

- (void)unsaveCollectDeal:(YYDeal *)deal
{
    [self.collectDeals removeObject:deal];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.collectDeals toFile:YYCollectDealsFile];
}

- (void)unsaveCollectDeals:(NSArray *)deals
{
    [self.collectDeals removeObjectsInArray:deals];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:self.collectDeals toFile:YYCollectDealsFile];
}

@end
