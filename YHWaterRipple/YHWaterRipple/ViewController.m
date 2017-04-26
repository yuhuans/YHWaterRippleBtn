//
//  ViewController.m
//  YHWaterRippleBtn-master
//
//  Created by apple on 26/4/17.
//  Copyright © 2017年 于欢. All rights reserved.
//

#import "ViewController.h"
#import "YHWaterRippleBtn.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet YHWaterRippleBtn *innerBtn;
@property (weak, nonatomic) IBOutlet YHWaterRippleBtn *outerBtn;
@property (weak, nonatomic) IBOutlet YHWaterRippleBtn *innerCenterBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Set Button rippleType
    _innerBtn.rippleType=YHWaterRippleBtnTypeInner;
    _outerBtn.rippleType=YHWaterRippleBtnTypeOuter;
    _innerCenterBtn.rippleType=YHWaterRippleBtnTypeInnerCenter;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
