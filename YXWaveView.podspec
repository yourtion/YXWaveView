Pod::Spec.new do |s|

  s.name         = "YXWaveView"
  s.version      = "0.7.0"
  s.summary      = "A water wave animation view"

  s.description  = <<-DESC
                    A water wave animation view with a over view float
                  DESC
  s.homepage     = "https://github.com/yourtion/YXWaveView"
  s.license      = "MIT"
  s.author       = { "Yourtion" => "yourtion@gmail.com" }
  s.source       = { :git => "https://github.com/yourtion/YXWaveView.git", :tag => s.version  }
  s.screenshots  = "https://raw.githubusercontent.com/yourtion/YXWaveView/master/ScreenShot.gif"
  s.source_files = "YXWaveView"
  
  s.ios.deployment_target = '8.0'
  
  s.frameworks  = "Foundation"
  s.requires_arc = true

end
