Pod::Spec.new do |s|
s.name         = 'APBlockKit'
s.version      = '0.0.1'
s.summary      = 'A short description of APBlockKit.'
s.homepage     = 'http://EXAMPLE/APBlockKit'
s.license      = 'MIT'
s.authors      = { 'chenyim' => 'ccc7501@closeli.cn' }
s.ios.deployment_target = '8.0'
s.source       = {:git => 'https://ChenYim@github.com/ChenYim/APBlockKit.git', :tag => s.version}
s.requires_arc = true
s.source_files = 'Classes", "Classes/**/*.{h,m}'
end
