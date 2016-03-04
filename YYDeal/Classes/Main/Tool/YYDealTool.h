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
@interface YYDealTool : NSObject
/**
 *  搜索团购
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)findDeals:(YYFindDealsParam *)params success:(void (^)(YYFindDealsResult *result))success failure:(void (^)(NSError *error))failure;
@end
