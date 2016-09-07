//
//  YYDealTool.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/5.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//  业务类

#import <Foundation/Foundation.h>
#import "YYFindDealsParam.h"
#import "YYFindDealsResult.h"
#import "YYGetSingleDealParam.h"
#import "YYGetSingleDealResult.h"
@interface YYDealTool : NSObject
/**
 *  搜索团购
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)findDeals:(YYFindDealsParam *)params success:(void (^)(YYFindDealsResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获得指定团购（获得单个团购信息）
 */
+ (void)getSingleDeal:(YYGetSingleDealParam *)param success:(void (^)(YYGetSingleDealResult *result))success failure:(void (^)(NSError *error))failure;
@end
