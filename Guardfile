# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/mover_io/(.+)\.rb$})     { |m| "spec/mover_io/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

