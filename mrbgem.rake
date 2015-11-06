MRuby::Gem::Specification.new('mruby-datadog') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Yohei Kawahara'
  spec.add_dependency 'mruby-httprequest' 
  spec.add_dependency 'mruby-json'
  spec.add_dependency 'mruby-polarssl'
end

