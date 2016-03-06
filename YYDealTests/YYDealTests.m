//
//  YYDealTests.m
//  YYDealTests
//
//  Created by ihefe-0004 on 16/2/3.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YYMetaDataTool.h"
#import "YYCategory.h"
#import "YYCity.h"
#import "YYSort.h"
#import "YYCityGroup.h"

@interface YYDealTests : XCTestCase

@end

@implementation YYDealTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testLoadMetaData
{
    /**
     *  单元测试
     */
    YYMetaDataTool *tool = [YYMetaDataTool sharedMetaDataTool];
    XCTAssert(tool.categories.count > 0 , @"分类数据内容正确");
    XCTAssert(tool.cities.count > 0 , @"城市数据内容正确");
    XCTAssert(tool.cityGroups.count > 0 , @"城市组数据内容正确");
    XCTAssert(tool.sorts.count > 0 , @"排序数据内容正确");

    
    XCTAssert([[tool.categories firstObject] isKindOfClass:[YYCategory class]] , @"分类数据内容正确");

    for (YYCategory *c in tool.categories) {
        NSLog(@"-----%@  %@",c.name,c.subcategories);
    }
}
@end
