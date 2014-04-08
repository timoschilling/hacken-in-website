namespace :setup do

  desc "add an administrator, rake setup:admin user=USERNAME password=PASSWORD email=EMAIL"
  task admin: :environment do
    nick = ENV["user"] || begin
      puts "Username:"
      STDIN.gets.strip
    end

    password = ENV["password"] || begin
      puts "Password:"
      STDIN.gets.strip
    end

     email = ENV["email"] || begin
      puts "Emailaddress:"
      STDIN.gets.strip
    end

    if user = User.create!(nickname: nick, password: password, email: email)
      user.admin = true
      user.save
      puts "User created"
    end
  end

  desc "copy example config files"
  task :config do
    configs = {
      "config/database.yml_example" => "config/database.yml",
      "config/twitter.yml_example" => "config/twitter.yml",
      "config/initializers/devise.rb_example" => "config/initializers/devise.rb"
    }
    configs.each do |src, des|
      FileUtils.cp src, des
    end
  end
end
