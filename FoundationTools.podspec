Pod::Spec.new do |s|
  s.name             = 'FoundationTools'
  s.version          = '0.1'
  s.summary          = 'FoundationTools is a collection of helper classes and function defined on the Swift Foundation Framework'
  s.description      = <<-DESC
  FoundationTools is a collection of small helper classes and function defined on the Swift Foundation Framework which might be reused in different use cases. 
  DESC

  s.homepage         = 'https://github.com/psturm-swift/FoundationTools'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Patrick Sturm' => 'psturm.mail@googlemail.com' }
  s.source           = { :git => 'https://github.com/psturm-swift/FoundationTools.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/psturm_swift'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'Sources/*.swift'

  s.requires_arc = true
end
