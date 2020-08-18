Pod::Spec.new do |s|
  s.name         = "ZJBaseUtils"
  s.version      = "1.0.0"
  s.summary      = "Provide common、general、basic API and extensions for iOS Platform."

  s.description  = <<-DESC
    Provide common、general、basic API and extensions for iOS Platform.
                   DESC

  s.homepage     = "https://github.com/Eafy/ZJBaseUtils_iOS"
  s.license      = { :type => "Apache License 2.0", :file => "LICENSE" }
  s.author       = { "Eafy" => "lizhijian_21@163.com" }
  s.requires_arc = true
  s.ios.deployment_target   = "8.0"
  s.frameworks = ["UIKit", ""GLKit", "AVFoundation", "CoreLocation", "AssetsLibrary", "SystemConfiguration", "Photos", "Security" , "CoreText"]

  s.source       = { :git => "https://github.com/Eafy/ZJBaseUtils_iOS.git", :tag => "#{s.version}", :submodules => true }
  s.source_files  = "ZJBaseUtils/*.{h,m,mm,c,hpp,cpp}", "ZJBaseUtils/**/*.{h,m,mm,c,hpp,cpp}"
  s.public_header_files = "ZJBaseUtils/*.h", "ZJBaseUtils/**/*.h"

end
