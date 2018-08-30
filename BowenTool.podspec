Pod::Spec.new do |s|

s.name         = "BowenTool"
s.version      = "1.0.5"
s.platform     = :ios, "7.0"
s.ios.deployment_target = '7.0'
s.summary      = "bowen some tools"
s.homepage     = "https://github.com/linhongchen/BowenTool"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "Bowen" => "591741691@qq.com" }
s.source       = { :git => "https://github.com/linhongchen/BowenTool.git", :tag => s.version }
s.requires_arc = true
s.source_files = 'BowenTool/*','BowenTool/*.h'

s.subspec 'Category' do |cat|
  cat.source_files = 'BowenTool/Category/*.h'
  cat.subspec 'Foundation' do |fou|
    fou.resources = 'BowenTool/Category/*.wav'
    fou.source_files = 'BowenTool/Category/Foundation/*.{h,m}'
    fou.dependency 'SVProgressHUD','~> 2.2.5'
  end
  cat.subspec 'UIKit' do |uik|
    uik.source_files = 'BowenTool/Category/UIKit/*.{h,m}'
  end
end


s.subspec 'ThirdTool' do |thi|
  thi.source_files = 'BowenTool/ThirdTool/*.h'
  thi.subspec 'AES128ECB' do |aes|
    aes.source_files = 'BowenTool/ThirdTool/AES128ECB/**/*'
  end
end


s.subspec 'Networking' do |net|
  net.source_files = 'BowenTool/Networking/*.{h,m}'
  net.dependency 'AFNetworking','~> 3.2.1'
  net.dependency 'YYCache','~> 1.0.4'
end


end
