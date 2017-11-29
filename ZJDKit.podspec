#
# Be sure to run `pod lib lint ZJDKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZJDKit'
  s.version          = '0.5.4'
  s.summary          = '代码积累'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
个人代码库整理.
                       DESC

  s.homepage         = 'https://github.com/Sdfeidong/ZJDKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sdfeidong' => 'zh75701.aidong@qq.com' }
  s.source           = { :git => 'https://github.com/Sdfeidong/ZJDKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZJDKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZJDKit' => ['ZJDKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.frameworks = 'UIKit', 'SystemConfiguration', 'Foundation'

  s.dependency 'AFNetworking'
  s.dependency 'Reachability'
  s.dependency 'MBProgressHUD'
  s.dependency 'SDWebImage'
  s.dependency 'YYKit'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'DZNEmptyDataSet'

end
