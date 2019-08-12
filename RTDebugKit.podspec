#
# Be sure to run `pod lib lint RTDebugKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RTDebugKit'
  s.version          = '0.1.2'
  s.summary          = 'A helper library to add debug abilities in your app'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  It is a library to add debug functions in your app. All they appear with application shake on debug builds. They include:
  - in-app debugger
  - changing of backend endpoint
  - logging (console in debug mode and logz.io + sentry in release mode)
                       DESC

  s.homepage         = 'https://github.com/Rentateam/rtdebugkit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RentaTeam' => 'info@rentateam.ru' }
  s.source           = { :git => 'https://github.com/Rentateam/rtdebugkit.git', :tag => s.version.to_s }
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  s.ios.deployment_target = '10.3'
  s.swift_version = '4.0'

  s.source_files = 'RTDebugKit/Classes/**/*'
  s.resource_bundles = {
      'RTDebugKit' => ['RTDebugKit/Assets/**/*.{storyboard,xib,xcassets,json,imageset,png}']
  }
  s.dependency 'Alamofire'
  s.dependency 'AlamofireActivityLogger'
  s.dependency 'JustLog'
  s.dependency 'Sentry'
  s.dependency 'FLEX'
  s.dependency 'TTWindowManager'
end
