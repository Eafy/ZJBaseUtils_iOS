Pod::Spec.new do |s|
  s.name         = "ZJBaseUtils"
  s.version      = "1.2.9-beta3"
  s.summary      = "ZJBaseUtils."

  s.description  = <<-DESC
  Provide basic functions and extensions for ZJ iOS Platform.
                   DESC

  s.homepage     = "http://git.i-jimi.com.cn/COMM/app/jmsmartutils-ios"
  s.license      = { :type => "Apache License 2.0", :file => "LICENSE" }
  s.author       = { "eafy" => "eafy@jimilab.com" }
  s.platform     = :ios, "9.0"
  s.requires_arc = true
  s.frameworks = 'GLKit','AVFoundation','CoreLocation','AssetsLibrary','SystemConfiguration','Photos','Security','UIKit','CoreText','CoreServices','UserNotifications'

  s.source       = { :git => "git@git.i-jimi.com.cn:COMM/app/jmsmartutils-ios.git", :tag => "v#{s.version}" }

  s.source_files  = "ZJBaseUtils/**/*.{h,m,mm,c,hpp,cpp}","ZJBaseUtils/*.{h,m,mm,c,hpp,cpp}"
  s.public_header_files = "ZJBaseUtils/**/*.h","ZJBaseUtils/*.h"
  s.private_header_files = "ZJBaseUtils/**/ZJNetRoute.hpp", "ZJBaseUtils/**/ZJSAMKeychain.h"
  
  s.resource_bundles = {
    'ZJBundleRes' => ['ZJBaseUtils/Resources/*.png']
  }
  
end

#校验指令
#pod lib lint ZJBaseUtils.podspec --verbose --allow-warnings --use-libraries
#打包指令
#pod package ZJBaseUtils.podspec --force --no-mangle --exclude-deps --verbose
#发布命令
#pod trunk push ZJBaseUtils.podspec --verbose --allow-warnings --use-libraries
