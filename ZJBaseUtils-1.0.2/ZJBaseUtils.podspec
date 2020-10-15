Pod::Spec.new do |s|
  s.name = "ZJBaseUtils"
  s.version = "1.0.2"
  s.summary = "Provide common\u3001general\u3001basic API and extensions for iOS Platform."
  s.license = {"type"=>"Apache License 2.0", "file"=>"LICENSE"}
  s.authors = {"Eafy"=>"lizhijian_21@163.com"}
  s.homepage = "https://github.com/Eafy/ZJBaseUtils_iOS"
  s.description = "Provide common\u3001general\u3001basic API and extensions for iOS Platform."
  s.frameworks = ["UIKit", "GLKit", "AVFoundation", "CoreLocation", "AssetsLibrary", "SystemConfiguration", "Photos", "Security", "CoreText"]
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/ZJBaseUtils.framework'
end
