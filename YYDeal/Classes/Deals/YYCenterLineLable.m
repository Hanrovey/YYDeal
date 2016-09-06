//
//  YYCenterLineLable.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCenterLineLable.h"

@implementation YYCenterLineLable

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 绘制颜色
    [self.textColor set];
    
    // 矩形框的值
    CGFloat x = 0;
    CGFloat y = self.height * 0.5;
    CGFloat w = self.width;
    CGFloat h = 0.5;
    
    UIRectFill(CGRectMake(x, y, w, h));
}


@end
