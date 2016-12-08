//
//  HeaderView.m
//  OTP
//
//  Created by zhangbaihu on 16/12/8.
//  Copyright © 2016年 wanwei. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(150, 20, 100, 40);
    [btn setTitle:@"添加动态码" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)btnClick {
    if (self.btnBlock) {
        self.btnBlock();
    }
}

@end
