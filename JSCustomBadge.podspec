Pod::Spec.new do |s|
  s.name     = 'JSCustomBadge'
  s.version  = '1.0.2'
  s.license  = 'MIT'
  s.summary  = 'A simple iOS badge drawn with CoreGraphics.'
  s.homepage = 'https://github.com/jessesquires/JSCustomBadge'
  s.author   = 'Jesse Squires'
  s.source   = { :git => 'https://github.com/jessesquires/JSCustomBadge.git', :tag => s.version }
  s.platform = :ios
  s.source_files = 'JSCustomBadge'
  s.requires_arc = true
  s.framework = 'QuartzCore'

  s.deprecated = true
end
