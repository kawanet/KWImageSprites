Pod::Spec.new do |s|
  s.name         = "KWImageSprites"
  s.version      = "0.0.1"
  s.summary      = "split images like CSS sprite"
  s.homepage     = "https://github.com/kawanet/KWImageSprites"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { "Yusuke Kawasaki" => "u-suke@kawa.net" }
  s.source       = { :git => "https://github.com/kawanet/KWImageSprites.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'src'
  s.requires_arc = true
end
