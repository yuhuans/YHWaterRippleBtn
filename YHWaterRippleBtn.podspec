Pod::Spec.new do |s|

  s.name         = "YHWaterRippleBtn"
  s.version      = "1.0"
  s.summary      = "Ripple Button"
  s.description  = <<-DESC
                        自定义按钮纹波效应,它是简单的集成和可定制的组件
                   DESC
  s.homepage     = "https://github.com/yuhuans/YHWaterRippleBtn"
  s.license      = "MIT"
  s.author             = { "yuhuanwater" => "260647768@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/yuhuans/YHWaterRippleBtn.git", :tag => "#{s.version}" }
  s.source_files  =  "YHWaterRipple/YHWaterRipple/YHWaterRippleBtn/*.{h,m}"

end
