Pod::Spec.new do |s|

s.name         = "BowenTool"
s.version      = "1.0.1"
s.platform     = :ios, "7.0"
s.ios.deployment_target = '7.0'
s.summary      = "bowen some tools"
s.homepage     = "https://github.com/linhongchen/BowenTool"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "Bowen" => "591741691@qq.com" }
s.source       = { :git => "https://github.com/linhongchen/BowenTool.git", :tag => s.version }
s.source_files = 'BowenTool/**/{*.h,*.m}'
s.requires_arc = true

end
