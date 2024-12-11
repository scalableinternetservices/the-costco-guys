namespace :db do
  desc "Run db:seed"
  task seed: :environment do
    puts "Running db:seed..."
    Rake::Task["db:seed"].invoke
    puts "db:seed completed."
  end
end