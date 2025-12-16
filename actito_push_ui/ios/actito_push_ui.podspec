require 'yaml'

pubspec = YAML.load(File.read(File.join(__dir__, "..", "pubspec.yaml")))
actito_version = '5.0.0-beta.2'

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = pubspec['version']
  s.summary          = 'Actito Push UI Flutter Plugin'
  s.description      = <<-DESC
The Actito Flutter Plugin implements the power of smart notifications, location services, contextual marketing and powerful loyalty solutions provided by the Actito platform in Flutter applications.

For documentation please refer to: https://developers.actito.com
For support please use: https://www.actito.com/en-BE/contact/support/
                       DESC
  s.homepage         = 'https://actito.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Actito' => 'mobile@actito.com' }
  s.source           = { :path => '.' }
  s.source_files = 'actito_push_ui/Sources/actito_push_ui/**/*'
  s.dependency 'Flutter'
  s.dependency 'Actito/ActitoKit', actito_version
  s.dependency 'Actito/ActitoPushUIKit', actito_version
  s.platform = :ios, '13.0'
  s.swift_version = '5.0'
end
