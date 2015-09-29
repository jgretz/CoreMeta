#
# Be sure to run `pod lib lint CoreMeta.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CoreMeta"
  s.version          = "1.0.0"
  s.summary          = "IOC / DI for iOS, Binding Framework, and some other goodies."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "For more information, please visit http://www.gretzlab.com or check out the example project."

  s.homepage         = "https://github.com/jgretz/CoreMeta"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Andrew Holt" => "jgretz@truefitinnovation.com" }
  s.source           = { :git => "https://github.com/jgretz/CoreMeta.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jgretz'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CoreMeta' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
