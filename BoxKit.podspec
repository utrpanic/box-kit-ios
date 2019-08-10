#
# Be sure to run `pod lib lint BoxKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BoxKit'
  s.version          = '2.1.0'
  s.summary          = 'Extensions for personal use.'

  s.homepage         = 'https://github.com/utrpanic/box-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'utrpanic' => 'utrpanic@gmail.com' }
  s.source           = { :git => 'https://github.com/utrpanic/box-kit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_versions = '5.0'
  s.source_files = 'BoxKit/*'
  s.frameworks = 'UIKit'
  s.static_framework = true
  s.dependency 'AnyCodable-FlightSchool', '~> 0.2.2'
end
