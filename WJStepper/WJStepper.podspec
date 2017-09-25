
Pod::Spec.new do |s|

  s.name         = "WJStepper"
  s.version      = "0.0.1"
  s.summary      = "A short description of WJStepper."
  s.homepage     = "https://github.com/sunhongjihaha/WJStepper"
  s.license      = "MIT"
  s.author       = { "孙鸿吉" => "395705277@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/sunhongjihaha/WJStepper/WJStepper.git", :tag => "#{s.version}" }
  s.source_files  = "WJStepper", "WJStepper/**/*.{h,m}"
  s.frameworks = "UIKit", "Foudation"
  s.dependency "Masonry", "~> 1.0.2"

end
