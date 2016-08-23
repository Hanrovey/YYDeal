//
//  YYMetaDataTool.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYMetaDataTool.h"
#import "YYCategory.h"
#import "YYCity.h"
#import "YYSort.h"
#import "YYCityGroup.h"

@interface YYMetaDataTool()
{
    /** 所有的分类 */
    NSArray *_categories;
    /** 所有的城市 */
    NSArray *_cities;
    /** 所有的城市组 */
    NSArray *_cityGroups;
    /** 所有的排序 */
    NSArray *_sorts;
}
@end

@implementation YYMetaDataTool
YYSingletonM(MetaDataTool)

- (NSArray *)categories
{
    if (!_categories) {
        _categories = [YYCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [YYCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}

- (NSArray *)cities
{
    if (!_cities) {
        _cities = [YYCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

- (NSArray *)sorts
{
    if (!_sorts) {
        _sorts = [YYSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

- (YYCity *)cityWithName:(NSString *)name
{
    if (name.length == 0) return nil;
    
    for (YYCity *city in self.cities) {
        if ([city.name isEqualToString:name]) return city;
    }
    
    return nil;
}



@end
