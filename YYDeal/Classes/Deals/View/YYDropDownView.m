//
//  YYDropDownView.m
//  YYDeal
//
//  Created by ihefe_Hanrovey on 16/5/13.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDropDownView.h"

@interface YYDropDownView() <UITableViewDelegate,UITableViewDataSource>
/* 主表 */
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
/* 从表 */
@property (weak, nonatomic) IBOutlet UITableView *subTable;

@end

@implementation YYDropDownView

+ (instancetype)menu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YYDropDownView" owner:self options:nil] lastObject];
}

// initWithCoder:(NSCoder *)aDecoder --> awakeFromNib(xib中的所有属性、方法已经连线成功)


/**
 *  一个UI控件即将添加到窗口中就调用
 */
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    self.mainTable.backgroundColor = [UIColor redColor];
    self.subTable.backgroundColor = [UIColor blueColor];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.mainTable) {
        return 15;
    }else{
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == self.mainTable) {
        cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
    }else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row + 100];
    }
    
    
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
