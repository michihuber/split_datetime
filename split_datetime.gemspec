$:.push File.expand_path("../lib", __FILE__)
require 'split_datetime/version'

Gem::Specification.new do |s|
  s.name        = "split_datetime"
  s.version     = SplitDatetime::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michi Huber"]
  s.email       = ["michi.huber@gmail.com"]
  s.homepage    = "http://github.com/michihuber/split_datetime"
  s.summary     = "Split datetime inputs into text and dropdowns in rails views"
  s.description = <<-END
    Adds accessors to a class so that the date can be set as a string while minutes and hours can be set as integers. This allows you to have an input textfield (with a javascript datepicker) for the date and dropdowns for the time.
END

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.11'
end
