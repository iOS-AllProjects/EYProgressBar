Pod::Spec.new do |s|
  s.name             = 'EYProgressBar'
  s.version          = '0.1.0'
  s.summary          = 'Custom Progress Bar written in swift 3.'
 
  s.description      = <<-DESC
This fantastic tracker will make your UI look beautiful!
                       DESC
 
  s.homepage         = 'https://github.com/iOS-AllProjects'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '<Etjen Ymeraj>' => '<etjenymeraj@gmail.com>' }
  s.source           = { :git => 'https://github.com/iOS-AllProjects/EYProgressBar.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'EYProgressBar/*.swift'
 
end