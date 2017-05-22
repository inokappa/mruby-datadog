MRuby::Gem::Specification.new('mruby-datadog') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Yohei Kawahara'
  spec.description = 'Datadog API Client gem for mruby'
  spec.homepage = 'https://github.com/inokappa/mruby-datadog'
  # spec.add_dependency 'mruby-httprequest' 
  spec.add_dependency 'mruby-json'
  spec.add_dependency 'mruby-polarssl'

  # spec.cc.flags = "-std=c99"
end
