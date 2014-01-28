require "rake/testtask"

Rake::TestTask.new(test: "db:test:prepare") do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

MiniTest::Rails::Testing.default_tasks << "features"

task default: :test
