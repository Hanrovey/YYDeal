//
//  YYDealCell.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/1.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealCell.h"
#import "YYDeal.h"
#import "UIImageView+WebCache.h"
@interface YYDealCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@end
@implementation YYDealCell

- (void)setDeal:(YYDeal *)deal
{
    _deal = deal;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    // 标题
    self.titleLabel.text = deal.title;
    // 描述
    self.descLabel.text = deal.desc;
    // 现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%.0f", deal.current_price];
    // 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%.0f", deal.list_price];
    // 购买数
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售出%d", deal.purchase_count];
}

- (void)drawRect:(CGRect)rect
{
    // 绘制cell的默认背景图
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}
@end
