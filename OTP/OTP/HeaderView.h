//
//  HeaderView.h
//  OTP
//
//  Created by zhangbaihu on 16/12/8.
//  Copyright © 2016年 wanwei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BtnBlock)();
@interface HeaderView : UIView
@property (nonatomic, strong) BtnBlock btnBlock;
@end
