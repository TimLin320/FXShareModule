#
# Be sure to run `pod lib lint FXShareModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FXShareModule'
  s.version          = '0.1.0'
  s.summary          = 'FXShareModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  FXShareModule.
                           DESC

  s.homepage         = 'https://github.com/TimLin320/FXShareModule.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linmeng320@gmail.com' => 'linmeng320@163.com' }
  s.source           = { :git => 'https://github.com/TimLin320/FXShareModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'

  s.dependency 'AKExts'
  s.dependency 'AKHud'
  s.dependency 'Masonry'
  s.dependency 'WX'

  s.ios.deployment_target = '9.0'
  s.static_framework = true

  s.source_files = 'FXShareModule/Classes/**/*'

#   s.resource_bundles = {
#     'FXShareModule' => ['FXShareModule/Assets/*.png']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
