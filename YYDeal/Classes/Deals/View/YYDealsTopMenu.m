//
//  YYDealsTopMenu.m
//  YYDeal
//
//  Created by ihefe-0004 on 16/3/9.
//  Copyright © 2016年 Hanrovey. All rights reserved.
//

#import "YYDealsTopMenu.h"

@interface YYDealsTopMenu()
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)imageButtonClick:(UIButton *)sender;
@end

@implementation YYDealsTopMenu

+ (instancetype)menu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YYDealsTopMenu" owner:self options:nil] lastObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
#warning 禁止默认的拉伸现象
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

- (IBAction)imageButtonClick:(UIButton *)sender {
}
@end
