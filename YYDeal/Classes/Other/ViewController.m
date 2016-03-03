//
//  ViewController.m
//  YYDeal(HD)
//
//  Created by ihefe-0004 on 16/3/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "ViewController.h"
#import "YYAPITool.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YYAPITool *tool = [YYAPITool sharedAPITool];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = @"北京";

    [tool requestWithUrl:@"v1/deal/find_deals" param:params success:^(id json) {
        
        NSLog(@"北京-success------%@",json);
    } failure:^(NSError *error) {
        
        NSLog(@"北京-success------%@",error);
    }];
    
    
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    params2[@"city"] = @"上海";
    params2[@"category"] = @"KTV";
    
    [tool requestWithUrl:@"v1/deal/find_deals" param:params2 success:^(id json) {
        
        NSLog(@"上海-success------%@",json);
    } failure:^(NSError *error) {
        
        NSLog(@"上海-success------%@",error);
    }];

    
}

@end
