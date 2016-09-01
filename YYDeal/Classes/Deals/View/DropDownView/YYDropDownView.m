//
//  YYDropDownView.m
//  YYDeal
//
//  Created by ihefe_Hanrovey on 16/5/13.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDropDownView.h"
#import "YYDropDownViewMainCell.h"
#import "YYDropDownSubCell.h"

@interface YYDropDownView() <UITableViewDelegate,UITableViewDataSource>
/* 主表 */
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
/* 从表 */
@property (weak, nonatomic) IBOutlet UITableView *subTable;

@end

@implementation YYDropDownView

+ (instancetype)menu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YYDropDownView" owner:nil options:nil] lastObject];
}

#pragma mark - 公共方法
- (void)selectMain:(int)mainRow
{
    [self.mainTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:mainRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.subTable reloadData];
}

- (void)selectSub:(int)subRow
{
    [self.subTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:subRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

// initWithCoder:(NSCoder *)aDecoder --> awakeFromNib(xib中的所有属性、方法已经连线成功)


/**
 *  一个UI控件即将添加到窗口中就调用
 */
//- (void)willMoveToWindow:(UIWindow *)newWindow
//{
//    self.mainTable.backgroundColor = [UIColor redColor];
//    self.subTable.backgroundColor = [UIColor blueColor];
//}

#pragma mark - 公共方法
- (void)setItems:(NSArray *)items
{
    _items = items;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.mainTable reloadData];
        [self.subTable reloadData];
    });
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.mainTable) {
        return self.items.count;
    }else{
        
        // 得到mainTableView选中的行
        int mainRow = [self.mainTable indexPathForSelectedRow].row;
        id<YYDropDownViewItem> item = self.items[mainRow];
        return [item subtitles].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTable){ // 左边主表的cell
        YYDropDownViewMainCell *mainCell = [YYDropDownViewMainCell cellWithTableView:tableView];
        mainCell.item = self.items[indexPath.row];
        
        return mainCell;
    }else{ // 右边从表的cell
        YYDropDownSubCell *subCell = [YYDropDownSubCell cellWithTableView:tableView];
        
        // 得到mainTableView选中的行
        int mainRow = [self.mainTable indexPathForSelectedRow].row;
        id<YYDropDownViewItem> item = self.items[mainRow];
        subCell.textLabel.text = [item subtitles][indexPath.row];
        return subCell;
    }
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTable)//左边的主表
    {
        // 刷新右边
        [self.subTable reloadData];
        
        if ([self.delegate respondsToSelector:@selector(dropDownView:didSelectMain:)])
        {
            [self.delegate dropDownView:self didSelectMain:indexPath.row];
        }
        
    }else//右边的子表
    {
        if ([self.delegate respondsToSelector:@selector(dropDownView:didSelectSub:ofMain:)])
        {
            int mainRow = [self.mainTable indexPathForSelectedRow].row;
            [self.delegate dropDownView:self didSelectSub:indexPath.row ofMain:mainRow];
        }
    }
}

@end
