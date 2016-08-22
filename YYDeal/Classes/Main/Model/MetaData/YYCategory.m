//
//  YYCategory.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/6.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYCategory.h"

@implementation YYCategory
- (NSString *)title
{
    return self.name;
}

- (NSArray *)subtitles
{
    return self.subcategories;
}

- (NSString *)image
{
    return self.small_icon;
}

- (NSString *)highlightedImage
{
    return self.small_highlighted_icon;
}
@end
