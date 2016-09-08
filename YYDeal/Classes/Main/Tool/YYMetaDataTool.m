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

#define YYSelectedCityNamesFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selected_city_names.plist"]
#define YYSelectedSortFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selected_sort.data"]
@interface YYMetaDataTool()
{
    /** 所有的分类 */
    NSArray *_categories;
    /** 所有的城市 */
    NSArray *_cities;
    /** 所有的排序 */
    NSArray *_sorts;
}

@property (nonatomic, strong) NSMutableArray *selectedCityNames;
@end

@implementation YYMetaDataTool
YYSingletonM(MetaDataTool)

- (NSMutableArray *)selectedCityNames
{
    if (!_selectedCityNames) {
        _selectedCityNames = [NSMutableArray arrayWithContentsOfFile:YYSelectedCityNamesFile];
        
        if (!_selectedCityNames) {
            _selectedCityNames = [NSMutableArray array];
        }
    }
    return _selectedCityNames;
}

- (NSArray *)categories
{
    if (!_categories) {
        _categories = [YYCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

- (NSArray *)cityGroups
{
        
    NSMutableArray *cityGroups = [NSMutableArray array];
    
    // 添加最近访问
    if (self.selectedCityNames.count) {
        YYCityGroup *recentCityGroup = [[YYCityGroup alloc] init];
        recentCityGroup.title = @"最近";
        recentCityGroup.cities = self.selectedCityNames;
        [cityGroups addObject:recentCityGroup];
    }
    
    // 添加plist里面的城市组数据
    NSArray *plistCityGroups = [YYCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    [cityGroups addObjectsFromArray:plistCityGroups];
    return cityGroups;
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

#pragma mark - 存储方法
- (void)saveSelectedCityName:(NSString *)name
{
    if (name.length == 0) return;
    
    // 存储城市名字
    [self.selectedCityNames removeObject:name];
    [self.selectedCityNames insertObject:name atIndex:0];
    
    // 写入plist
    [self.selectedCityNames writeToFile:YYSelectedCityNamesFile atomically:YES];
}

- (void)saveSelectedSort:(YYSort *)sort
{
    if (sort == nil) return;
    
    [NSKeyedArchiver archiveRootObject:sort toFile:YYSelectedSortFile];
}

- (YYCity *)selectedCity
{
    NSString *cityName = [self.selectedCityNames firstObject];
    YYCity *city = [self cityWithName:cityName];
    if (city == nil) {
        city = [self cityWithName:@"上海"];
    }
    return city;
}

- (YYSort *)selectedSort
{
    YYSort *sort = [NSKeyedUnarchiver unarchiveObjectWithFile:YYSelectedSortFile];
    if (sort == nil) {
        sort = [self.sorts firstObject];
    }
    return sort;
}
@end
