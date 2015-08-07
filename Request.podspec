#
# Be sure to run `pod lib lint Request.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Request"
p
  s.version          = "0.1."
  s.summary          = "A library to facilitate requests to a server"
  s.description      = <<-DESC
                       A library to facilitate requests to a server
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/jmartos89/Request"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "juan" => "jmartos@sopinet.com" }
  s.source           = { :git => "https://github.com/jmartos89/Request.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/_jmartos'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/*.{h,m}'
  #s.resource_bundles = {
   # 'Request' => ['Pod/Assets/*.png']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'SVProgressHUD', :head
  s.dependency 'MD5Digest', :head
end
