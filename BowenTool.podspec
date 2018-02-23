Pod::Spec.new do |s|

s.name         = "BowenTool"
s.version      = "1.0.3"
s.platform     = :ios, "7.0"
s.ios.deployment_target = '7.0'
s.summary      = "bowen some tools"
s.homepage     = "https://github.com/linhongchen/BowenTool"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "Bowen" => "591741691@qq.com" }
s.source       = { :git => "https://github.com/linhongchen/BowenTool.git", :tag => s.version }
s.requires_arc = true
s.source_files = 'BowenTool/*.h', 'BowenTool/Category/*.h','BowenTool/ThirdTool/*.h'

s.subspec 'Category' do |ss|
ss.source_files = 'BowenTool/Category/**/*'
#s.resources    = 'BowenTool/Category/**/*.wav'
ss.dependency 'SVProgressHUD', '~> 2.2.1'
end


s.subspec 'ThirdTool' do |ss|
  ss.subspec 'AES128ECB' do |sss|
  sss.source_files = 'BowenTool/ThirdTool/AES128ECB/**/*'      
  end
end


s.subspec 'Networking' do |ss|
ss.source_files = 'BowenTool/Networking/*.{h,m}'
ss.dependency 'AFNetworking', '~> 3.0'
end


end
