Pod::Spec.new do |s|
  s.name               = "SWMailgun"
  s.version            = "1.0.3"
  s.summary            = "✉️ SWMailgun provides simple alternative APIs when you need to send an email with your iOS app using Mailgun"
  s.requires_arc       = true
  s.homepage           = "https://github.com/limadeveloper/SWMailgun"
  s.license            = "MIT"
  s.author             = { "John Lima" => "john.limadeveloper@gmail.com" }
  s.social_media_url   = "https://twitter.com/thejohnlima"
  s.platform           = :ios, "9.3"
  s.source             = { :git => "https://github.com/limadeveloper/SWMailgun.git", :tag => "#{s.version}" }
  s.source_files       = "Framework/SWMailgun/Source/**/*.{swift}"
  s.swift_version      = "4.1"
  s.dependency 'BaseNetworkKit'
end