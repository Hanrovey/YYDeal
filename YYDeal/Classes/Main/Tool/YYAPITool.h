//
//  YYAPITool.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYSingleton.h"

typedef void (^Success)(id json);
typedef void (^Failure)(NSError *error);

@interface YYAPITool : NSObject<NSCopying>
- (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param success:(Success)success failure:(Failure)failure;

YYSingletonH(APITool)
@end
