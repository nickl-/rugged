$:.push File.expand_path("../lib", __FILE__)
require 'rugged/version'

Gem::Specification.new do |s|
  s.name                  = "rugged"
  s.version               = Rugged::Version
  s.date                  = Time.now.strftime('%Y-%m-%d')
  s.summary               = "Rugged is a Ruby binding to the libgit2 linkable library"
  s.homepage              = "https://github.com/libgit2/rugged"
  s.email                 = "schacon@gmail.com"
  s.authors               = [ "Scott Chacon", "Vicent Marti" ]
  s.license               = "MIT"
  s.files                 = `git ls-files`.split($\)
  s.executables           = s.files.grep(%r{^examples/}).map{|f| File.basename(f)}
  s.test_files            = s.files.grep(%r{^(test|spec|features)/})
  s.extensions            = s.files.grep(%r{^ext/.*.rb$})
  `git submodule --quiet update --init`
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      relative_to = submodule_path[/#{File.dirname(__FILE__)}\/(.*)/,1]
      s.files += `git ls-files|awk '!/"/{print "#{relative_to}/"$0}'`.split($\)
    end
  end
  s.required_ruby_version = '>= 1.9.3'
  s.description           = <<desc
Rugged is a Ruby bindings to the libgit2 linkable C Git library. This is
for testing and using the libgit2 library in a language that is awesome.
desc
  s.add_development_dependency "rake-compiler", ">= 0.9.0"
  s.add_development_dependency "pry"
  s.add_development_dependency "minitest", "~> 3.0.0"
end
