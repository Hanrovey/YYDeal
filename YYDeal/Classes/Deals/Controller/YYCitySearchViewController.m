//
//  YYCitySearchViewController.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/8/23.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCitySearchViewController.h"
#import "YYCity.h"
@interface YYCitySearchViewController ()
@property(nonatomic, strong) NSArray *resultCities;
@end

@implementation YYCitySearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = [searchText copy];
    
    // 根据搜索条件进行过滤
    NSArray *allCities = [YYMetaDataTool sharedMetaDataTool].cities;
    
    // 将搜索条件转为小写
    NSString *lowerSearchText = searchText.lowercaseString;
    
//    NSMutableArray *cities = [NSMutableArray array];
//    for (YYCity *city in allCities)
//    {
//        BOOL d1 = [city.name.lowercaseString rangeOfString:lowerSearchText].length != 0;
//        BOOL d2 = [city.pinYin.lowercaseString rangeOfString:lowerSearchText].length != 0;
//        BOOL d3 = [city.pinYinHead.lowercaseString rangeOfString:lowerSearchText].length != 0;
//
//        if (d1 || d2 || d3)
//        {
//            [cities addObject:city];
//        }
//    }
//    self.resultCities = cities;
    
    // NSpredicate 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name.lowercaseString contains %@ or pinYin.lowercaseString contains %@ or pinYinHead.lowercaseString contains %@",lowerSearchText,lowerSearchText,lowerSearchText];
    self.resultCities = [allCities filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"city";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    YYCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%ld个搜索结果", self.resultCities.count];
}
@end
