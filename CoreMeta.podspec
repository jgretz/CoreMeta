#
# Be sure to run `pod lib lint CoreMeta.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CoreMeta"
  s.version          = "2.0.1"
  s.summary          = "IOC / DI for iOS"
  s.description      = "For more information, please visit http://www.gretzlab.com"

  s.homepage         = "https://github.com/jgretz/CoreMeta"
  s.license          = 'Apache 2.0'
  s.author           = { "Josh Gretz" => "jgretz@truefit.io" }
  s.source           = { :git => "https://github.com/jgretz/CoreMeta.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/joshgretz'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'CoreMeta/CoreMeta/**/*.{swift}'
  s.resource_bundles = {
    'CoreMeta' => ['Pod/Assets/*.png']
  }
end
