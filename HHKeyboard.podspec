#
#  Be sure to run `pod spec lint HHKeyboard.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "HHKeyboard"
  spec.version      = "0.0.3"
  spec.summary      = "A short description of HHKeyboard."
  spec.description  = <<-DESC
TODO: Add long description of the pod here.
                   DESC

  spec.homepage     = "https://github.com/hutaol/HHKeyboard"
  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "henry" => "1325049637@qq.com" }
  spec.ios.deployment_target = '9.0'

  spec.source       = { :git => "https://github.com/hutaol/HHKeyboard.git", :tag => "#{spec.version}" }

  spec.source_files = "HHKeyboard/Classes/*"
  spec.resources    = 'HHKeyboard/Resources/*'

  spec.requires_arc = true

end
