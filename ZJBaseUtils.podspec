Pod::Spec.new do |s|
  s.name         = "ZJBaseUtils"
  s.version      = "1.4.3"
  s.summary      = "Provide common、general、basic API and extensions for iOS Platform."

  s.description  = <<-DESC
    Provide common、general、basic API and extensions for iOS Platform.
                   DESC

  s.homepage     = "https://github.com/Eafy/ZJBaseUtils_iOS"
  s.license      = { :type => "MIT"}
  s.author       = 'Eafy'
  s.requires_arc = true
  s.ios.deployment_target   = '11.0'
  s.swift_version = '5.0'
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7s armv7'
  }
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7s armv7'
  }
  
  s.frameworks = 'GLKit','AVFoundation','CoreLocation','AssetsLibrary','SystemConfiguration','Photos','Security','UIKit','CoreText','CoreServices','UserNotifications','CoreTelephony'

  s.source       = { :git => "https://github.com/Eafy/ZJBaseUtils_iOS.git", :tag => "v#{s.version}"}
  s.source_files  = "ZJBaseUtils/*.{h,m,mm,c,hpp,cpp,swift}", "ZJBaseUtils/**/*.{h,m,mm,c,hpp,cpp,swift}"
  s.public_header_files = "ZJBaseUtils/*.h", "ZJBaseUtils/**/*.h"
  s.private_header_files = "ZJBaseUtils/**/ZJSAMKeychain.h","ZJBaseUtils/**/ZJNetRoute.hpp","ZJBaseUtils/**/ZJNetRoute.hpp", "ZJBaseUtils/**/ZJBaseVCSharedAPI.h"
  
  s.resource_bundles = {
    'ZJBundleRes' => ['ZJBaseUtils/Resources/*.png']
  }

end

#校验指令
#pod lib lint ZJBaseUtils.podspec --verbose --allow-warnings --use-libraries
#打包指令
#pod package ZJBaseUtils.podspec --force --no-mangle --exclude-deps --verbose
#推送命令
#pod trunk push ZJBaseUtils.podspec --verbose --allow-warnings --use-libraries
