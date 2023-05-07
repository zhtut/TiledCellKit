#
# Be sure to run `pod lib lint TiledCellKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TiledCellKit'
  s.version          = '0.2.0'
  s.summary          = '一个用于Swift的TableView和CollectionView的管理模型和Cell绑定关系的组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  TiledCellKit是一个TableView和CollectionView模型对cell辅助对应关系的iOS的Swift库
  它的基本理念是一种cell对应一种Item，并且通过绑定关系绑定起来，tableView只需要操作item，即可对cell进行定制，达到cell类型和模型比较纯粹的关系
                       DESC

  s.homepage         = 'https://github.com/zhtut/TiledCellKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhtut' => 'tutu.tg.zhou@hstong.com' }
  s.source           = { :git => 'https://github.com/zhtut/TiledCellKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.source_files = 'TiledCellKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TiledCellKit' => ['TiledCellKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'ENABLE_MODULE_VERIFIER' => 'YES' }
  
end
