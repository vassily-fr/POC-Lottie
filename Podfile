inhibit_all_warnings!
use_frameworks!
platform :ios, '14.0'

source 'https://cdn.cocoapods.org/'
source 'git@bitbucket.org:DeltaDore/deltadorepodspecs.git'

target 'Poc-Lottie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for POC-SVGView
  pod 'lottie-ios'
  pod 'DeltaDoreDesignSystem', :path => '../../../DeltaDoreDesignSystem'

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['OTHER_LDFLAGS'] = '-weak_framework Combine -weak_framework SwiftUI'
    end
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['OTHER_LDFLAGS'] = '-weak_framework Combine -weak_framework SwiftUI'
    end
  end
end
