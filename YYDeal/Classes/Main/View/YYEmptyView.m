
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

- (void)didMoveToSuperview
{
    // 填充整个父控件
    [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

@end
