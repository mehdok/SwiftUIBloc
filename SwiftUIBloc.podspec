Pod::Spec.new do |s|
  s.name             = 'SwiftUIBloc'
  s.version          = '0.1.0'
  s.summary          = 'The Bloc Pattern is a way to separate UI and Logic in SwiftUI codes.'
  s.homepage         = 'https://github.com/mehdok/SwiftUIBloc'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Mehdi Sohrabi' => 'mehdok@gmail.com' }
  s.source           = { :git => 'https://github.com/mehdok/SwiftUIBloc.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/SwiftUIBloc/**/*'
end
