//
//  YYDealTool.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/5.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealTool.h"
#import "YYAPITool.h"
@implementation YYDealTool

+ (void)findDeals:(YYFindDealsParam *)params success:(void (^)(YYFindDealsResult *result))success failure:(void (^)(NSError *error))failure
{
    [[YYAPITool sharedAPITool] requestWithUrl:@"v1/deal/find_deals" param:params.keyValues success:^(id json) {
        
        if (success) {
            
            YYFindDealsResult *result = [YYFindDealsResult objectWithKeyValues:json];
            success(result);
            
        }
        
    } failure:failure];
}

+ (void)getSingleDeal:(YYGetSingleDealParam *)param success:(void (^)(YYGetSingleDealResult *result))success failure:(void (^)(NSError *error))failure
{
    [[YYAPITool sharedAPITool] requestWithUrl:@"v1/deal/get_single_deal" param:param.keyValues success:^(id json) {
        if (success)
        {
            YYGetSingleDealResult *obj = [YYGetSingleDealResult objectWithKeyValues:json];
            success(obj);
        }
    } failure:failure];
}
@end
