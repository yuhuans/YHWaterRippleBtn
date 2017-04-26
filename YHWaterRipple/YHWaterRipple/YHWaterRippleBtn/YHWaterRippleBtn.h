//
//  YHWaterRippleBtn.h
//  WZRippleButton
//
//  Created by apple on 14/4/17.
//  Copyright © 2017年 SatanWoo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YHWaterRippleBtnType) {
    YHWaterRippleBtnTypeInner = 0,
    YHWaterRippleBtnTypeOuter = 1,
    YHWaterRippleBtnTypeInnerCenter = 2,
};
@interface YHWaterRippleBtn : UIButton
@property (nonatomic, assign) YHWaterRippleBtnType rippleType;
@property (nonatomic, strong) UIColor *flashColor;
@property (nonatomic, assign) CGFloat animationDuration;
@end
