namespace :spec do
  namespace :fixtures do
    desc "Load fixtures from spec/fixtures"
    task :load do
      ENV['FIXTURES_PATH'] = "spec/fixtures"
      Rake::Task["db:fixtures:load"].invoke
    end

    desc "rebuild the fixtures if necessary"
    task :rebuild => :environment do
      require "#{Rails.root}/spec/support/fixture_builder"
    end
  end
end
