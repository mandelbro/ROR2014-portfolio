task :coverage do
  require 'coveralls'
  Coveralls.wear!('rails') # feel free to pass block
  Rake::Task["test"].execute
end
