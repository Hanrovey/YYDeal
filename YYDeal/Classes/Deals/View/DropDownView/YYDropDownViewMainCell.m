//
//  YYDropDownViewMainCell.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/8/22.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDropDownViewMainCell.h"
@interface YYDropDownViewMainCell()
@property (nonatomic, strong) UIImageView *rightArrow;
@end
@implementation YYDropDownViewMainCell

- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    }
    return _rightArrow;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"main";
    YYDropDownViewMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YYDropDownViewMainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView = selectedBg;
    }
    return self;
}

- (void)setItem:(id<YYDropDownViewItem>)item
{
    _item = item;

    // 标题
    self.textLabel.text = [item title];
    // 图标
    if ([item respondsToSelector:@selector(image)]) {
        self.imageView.image = [UIImage imageNamed:[item image]];
    }
    // 高亮图标
    if ([item respondsToSelector:@selector(highlightedImage)]) {
        self.imageView.highlightedImage = [UIImage imageNamed:[item highlightedImage]];
    }
    // 处理右边的箭头
    if ([item subtitles].count > 0) {
        self.accessoryView = self.rightArrow;
    }else
    {
        self.accessoryView = nil;
    }
}


@end
