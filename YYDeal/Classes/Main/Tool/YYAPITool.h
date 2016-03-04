//
//  YYAPITool.h
//  YYDeal
//  网络请求工具类
//  Created by ihefe-0004 on 16/3/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//  网络请求类

#import <Foundation/Foundation.h>
#import "YYSingleton.h"

typedef void (^Success)(id json);
typedef void (^Failure)(NSError *error);

@interface YYAPITool : NSObject<NSCopying>
- (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param success:(Success)success failure:(Failure)failure;

/**
 *  @author Hanrovey, 16-03-04 09:03:40
 *
 *  单例快速创建
 */
YYSingletonH(APITool)
@end
