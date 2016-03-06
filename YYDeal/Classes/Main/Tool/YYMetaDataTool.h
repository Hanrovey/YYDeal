//
//  YYMetaDataTool.h
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYSingleton.h"

@interface YYMetaDataTool : NSObject

YYSingletonH(MetaDataTool)

/**
 *  所有的分类
 */
@property (strong, nonatomic, readonly) NSArray *categories;
/**
 *  所有的城市
 */
@property (strong, nonatomic, readonly) NSArray *cities;
/**
 *  所有的城市组
 */
@property (strong, nonatomic, readonly) NSArray *cityGroups;
/**
 *  所有的排序
 */
@property (strong, nonatomic, readonly) NSArray *sorts;
@end
