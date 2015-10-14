#
# Be sure to run `pod lib lint CoreMeta.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CoreMeta"
  s.version          = "2.0.0"
  s.summary          = "IOC / DI for iOS, Binding Framework, and some other goodies."
  s.description      = "For more information, please visit http://www.gretzlab.com or check out the example project."

  s.homepage         = "https://github.com/jgretz/CoreMeta"
  s.license          = 'Apache 2.0'
  s.author           = { "Josh Gretz" => "jgretz@truefit.io" }
  s.source           = { :git => "https://github.com/jgretz/CoreMeta.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/joshgretz'

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
