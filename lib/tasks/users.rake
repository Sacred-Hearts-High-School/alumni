namespace :user do
  desc "Add the default user"
  task :default_user => :environment do
    User.create( :account => "admin", :name => 'Administrator', :password => 'ChangeMe', :is_admin=>true )
    User.create( :account => "manager", :name => 'Manager', :password => 'ChangeMe', :is_admin=>false )
  end

  desc "Run all tasks"
  task :all => [:default_user]

  # 預設資料匯入方式： RAILS_ENV=production rake lib/tasks/users.rake
end