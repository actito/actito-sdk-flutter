require 'yaml'

pubspec = YAML.load(File.read(File.join(__dir__, "..", "pubspec.yaml")))
actito_version = '5.0.0-beta.2'

Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = pubspec['version']
  s.summary          = 'Actito User Inbox Flutter Plugin'
  s.description      = <<-DESC
The Actito Flutter Plugin implements the power of smart notifications, location services, contextual marketing and powerful loyalty solutions provided by the Actito platform in Flutter applications.

For documentation please refer to: http://docs.notifica.re
For support please use: http://support.notifica.re
                       DESC
  s.homepage         = 'https://actito.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Actito' => 'product@actito.com' }
  s.source           = { :path => '.' }
  s.source_files = 'actito_user_inbox/Sources/actito_user_inbox/**/*'
  s.dependency 'Flutter'
  s.dependency 'Actito/ActitoKit', actito_version
  s.dependency 'Actito/ActitoUserInboxKit', actito_version
  s.platform = :ios, '13.0'
  s.swift_version = '5.0'
end
