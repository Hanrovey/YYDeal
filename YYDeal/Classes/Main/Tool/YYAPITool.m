//
//  YYAPITool.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYAPITool.h"
#import "DPAPI.h"

@interface YYAPITool()<DPRequestDelegate>
@property(nonatomic, strong) DPAPI *api;

//@property(nonatomic, strong) NSMutableDictionary *blocks;

@end

@implementation YYAPITool

YYSingletonM(APITool)

- (DPAPI *)api
{
    if (_api == nil) {
        _api = [[DPAPI alloc] init];
    }
    return _api;
}

//-(NSMutableDictionary *)blocks
//{
//    if (_blocks == nil) {
//        _blocks = [NSMutableDictionary dictionary];
//    }
//    return _blocks;
//}

- (void)requestWithUrl:(NSString *)url param:(NSDictionary *)param success:(Success)success failure:(Failure)failure
{
    DPRequest *request = [self.api requestWithURL:url params:[NSMutableDictionary dictionaryWithDictionary:param] delegate:self];
    request.success = success;
    request.failure = failure;
    
//    self.blocks[request.description] = ^(id json,NSError *error){
//        
//        if (success && json) {
//            success(json);
//        }
//        
//        if (failure && error) {
//            failure(error);
//        }
//        
//    };
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if (request.success) {
        request.success(result);
    }
    
//    void (^block)(id json,NSError *error) = self.blocks[request.description];
//    if (block) {
//        block(result,nil);
//    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    if (request.failure) {
        request.failure(error);
    }
    
//    void (^block)(id json,NSError *error) = self.blocks[request.description];
//    if (block) {
//        block(nil,error);
//    }

}

@end
