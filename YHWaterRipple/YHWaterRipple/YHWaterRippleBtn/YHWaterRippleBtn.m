//
//  YHWaterRippleBtn.m
//  WZRippleButton
//
//  Created by apple on 14/4/17.
//  Copyright © 2017年 SatanWoo. All rights reserved.
//

#import "YHWaterRippleBtn.h"
#import <objc/runtime.h>
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
    } while (0)
const CGFloat YHFlashInnerCircleInitialRaius = 5;
@interface YHWaterRippleBtn ()<CAAnimationDelegate>
@property (nonatomic, strong)id circleShape;
@property (nonatomic, assign)CGFloat scale;
@property (nonatomic, assign)SEL s_actionSEL;
@property (nonatomic, weak)id target;
@end
@implementation YHWaterRippleBtn
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.animationDuration=0.3f;
    self.rippleType=YHWaterRippleBtnTypeInner;
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    self.s_actionSEL=action;
    self.target=target;
}
#pragma mark -
#pragma mark - Private
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event{
    CGPoint tapLocation = [touch locationInView:self];

    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    self.scale = 2.5f;
    switch (self.rippleType) {
        case YHWaterRippleBtnTypeInnerCenter:{
            CGFloat biggerEdge = width > height ? width : height, smallerEdge = width > height ? height : width;
            CGFloat radius = smallerEdge / 2 > YHFlashInnerCircleInitialRaius ? YHFlashInnerCircleInitialRaius : smallerEdge / 2;
            
            self.scale = biggerEdge / radius + 0.5;
            self.circleShape = [self createCircleShapeWithPosition:CGPointMake(width/2, height/2)
                                                          pathRect:CGRectMake(0, 0, radius * 2, radius * 2)
                                                            radius:radius];
        }
            
            break;
        case YHWaterRippleBtnTypeInner:{
            CGFloat biggerEdge = width > height ? width : height, smallerEdge = width > height ? height : width;
            CGFloat radius = smallerEdge / 2 > YHFlashInnerCircleInitialRaius ? YHFlashInnerCircleInitialRaius : smallerEdge / 2;
            
            self.scale = biggerEdge / radius + 0.5;
            self.circleShape = [self createCircleShapeWithPosition:CGPointMake(tapLocation.x - radius, tapLocation.y - radius)
                                                          pathRect:CGRectMake(0, 0, radius * 2, radius * 2)
                                                            radius:radius];

        }
            
            break;
        case YHWaterRippleBtnTypeOuter:{
            self.circleShape = [self createCircleShapeWithPosition:CGPointMake(width/2, height/2)
                                                          pathRect:CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), width, height)
                                                            radius:self.layer.cornerRadius];
        }
            break;
        default:
            break;
    }
    
    [self.layer addSublayer:self.circleShape];

    return YES;
}


- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event{
//    CGPoint point = [touch locationInView:self];
    
//    if (point.x<0||point.y<0||point.x>self.bounds.size.width||point.y>self.bounds.size.height) {
//        [self.circleShape removeFromSuperlayer];
//        if ([self.target respondsToSelector:self.s_actionSEL]) {
//            SuppressPerformSelectorLeakWarning([self.target performSelector:self.s_actionSEL withObject:self];);
//        }
//    }else{
        CAAnimationGroup *groupAnimation = [self createFlashAnimationWithScale:self.scale duration:self.animationDuration];
        
        [groupAnimation setValue:self.circleShape forKey:@"circleShaperLayer"];
        groupAnimation.delegate =self;
        [self.circleShape addAnimation:groupAnimation forKey:nil];
//    }
}


- (CAShapeLayer *)createCircleShapeWithPosition:(CGPoint)position pathRect:(CGRect)rect radius:(CGFloat)radius
{
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    circleShape.path = [self createCirclePathWithRadius:rect radius:radius];
    circleShape.position = position;
    switch (self.rippleType) {
        case YHWaterRippleBtnTypeInner:
            circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
            circleShape.fillColor = self.flashColor ? self.flashColor.CGColor : [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
            break;
        case YHWaterRippleBtnTypeOuter:
            circleShape.fillColor = [UIColor clearColor].CGColor;
            circleShape.strokeColor = self.flashColor ? self.flashColor.CGColor : [UIColor whiteColor].CGColor;
            break;
        case YHWaterRippleBtnTypeInnerCenter:
            circleShape.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
            circleShape.fillColor = self.flashColor ? self.flashColor.CGColor : [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
            break;
        default:
            break;
    }
    
    circleShape.opacity = 0;
    circleShape.lineWidth = 1;
    
    return circleShape;
}

- (CAAnimationGroup *)createFlashAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[scaleAnimation, alphaAnimation];
    animation.delegate = self;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return animation;
}

- (CGPathRef)createCirclePathWithRadius:(CGRect)frame radius:(CGFloat)radius
{
    return [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
}
-(void)dealloc{
    self.target=nil;
}
#pragma mark -
#pragma mark - Setter
- (void)setRippleType:(YHWaterRippleBtnType)rippleType
{
    switch (rippleType) {
        case YHWaterRippleBtnTypeInnerCenter:
            self.clipsToBounds = NO;
            break;
        case YHWaterRippleBtnTypeOuter:
            self.clipsToBounds = NO;
            break;
        case YHWaterRippleBtnTypeInner:
            self.clipsToBounds = YES;
            break;
        default:
            break;
    }
    _rippleType = rippleType;
}
#pragma mark -
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    CALayer *layer = [anim valueForKey:@"circleShaperLayer"];
    if (layer) {
        [layer removeFromSuperlayer];
        if ([self.target respondsToSelector:self.s_actionSEL]) {
            SuppressPerformSelectorLeakWarning([self.target performSelector:self.s_actionSEL withObject:self];);
        }
    }
}

@end
