Pod::Spec.new do |s|
  s.name         = "ZJBaseUtils"
  s.version      = "1.0.2"
  s.summary      = "Provide common、general、basic API and extensions for iOS Platform."

  s.description  = <<-DESC
    Provide common、general、basic API and extensions for iOS Platform.
                   DESC

  s.homepage     = "https://github.com/Eafy/ZJBaseUtils_iOS"
  s.license      = { :type => "Apache License 2.0", :file => "LICENSE" }
  s.author       = { "Eafy" => "lizhijian_21@163.com" }
  s.requires_arc = true
  s.ios.deployment_target   = '8.0'
  s.frameworks = ["UIKit", "GLKit", "AVFoundation", "CoreLocation", "AssetsLibrary", "SystemConfiguration", "Photos", "Security", "CoreText"]
  s.source       = { :git => "https://github.com/Eafy/ZJBaseUtils_iOS.git", :tag => "#{s.version}"}
  s.ios.vendored_framework   = 'Release/ZJBaseUtils.framework'

end

#推送命令
#pod trunk push ZJBaseUtils.podspec --verbose --allow-warnings --use-libraries
