#
# Be sure to run `pod lib lint BoxKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BoxKit'
  s.version          = '2.2.2'
  s.summary          = 'Extensions for personal use.'

  s.homepage         = 'https://github.com/utrpanic/box-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'utrpanic' => 'utrpanic@gmail.com' }
  s.source           = { :git => 'https://github.com/utrpanic/box-kit-ios.git', :tag => 'v#{s.version}' }

  s.ios.deployment_target = '14.0'
  s.swift_versions = '5.0'
  s.source_files = 'Sources/BoxKit/**/*'
  s.dependency 'AnyCodable-FlightSchool', '~> 0'
end
