#
# Be sure to run `pod lib lint HHKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HHKeyboard'
  s.version          = '0.2.0'
  s.summary          = '一个简单的聊天键盘'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  聊天键盘：支持暗黑模式，语音，键盘，表情和更多类型配置
                       DESC

  s.homepage         = 'https://github.com/hutaol/HHKeyboard'
  s.screenshots     = 'https://github.com/hutaol/HHKeyboard/blob/main/Screenshots/screenshots_1.png', 'https://github.com/hutaol/HHKeyboard/blob/main/Screenshots/screenshots_2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Henry' => '1325049637@qq.com' }
  s.source           = { :git => 'https://github.com/hutaol/HHKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HHKeyboard/Classes/**/*'
  
  s.resource_bundles = {
    'HHKeyboard' => ['HHKeyboard/Assets/*.xcassets']
  }
  
  s.subspec 'Face' do |face|
    face.resources = "HHKeyboard/Assets/*.bundle"
  end

  s.requires_arc = true

end
