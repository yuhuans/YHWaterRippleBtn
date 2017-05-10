# YHWaterRippleBtn
自定义按钮纹波效应,它是简单的集成和可定制的组件。

<img src="https://github.com/yuhuans/YHWaterRippleBtn/blob/master/1.gif" width="208" height="369" /> . <img src="https://github.com/yuhuans/YHWaterRippleBtn/blob/master/2.gif" width="208" height="369" /> . <img src="https://github.com/yuhuans/YHWaterRippleBtn/blob/master/3.gif" width="208" height="369" />

## 使用说明

拖动文件YHWaterRippleBtn.h/YHWaterRippleBtn.m到您的项目，或者pod 'YHWaterRippleBtn'

```
YHWaterRippleBtn *btn=[[YHWaterRippleBtn alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
[btn setTitle:@"button" forState:UIControlStateNormal];
 btn.rippleType=YHWaterRippleBtnTypeInnerCenter;
[self.view addSubview:btn];
```

