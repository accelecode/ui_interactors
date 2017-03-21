task :default => :test
task :test do
  Dir.glob('./tests/*_test.rb').each { |file| require file}
end
