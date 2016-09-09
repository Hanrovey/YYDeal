
//
//  YYEmptyView.m
//  YYDeal
//
//  Created by Ihefe_Hanrovey on 16/9/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYEmptyView.h"

@implementation YYEmptyView

+ (instancetype)emptyView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置图片不拉伸
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

/**
 *  当一个控件被添加到父控件或者从父控件移除会调用（一旦从父控件中移除，self.superview是nil）
 */
- (void)didMoveToSuperview
{
#warning 如果父控件不为nil，才需要添加约束
    if (self.superview)
    {
        // 填充整个父控件
        [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    }
}

@end
