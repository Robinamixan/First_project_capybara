require_relative 'registration.rb'
require_relative 'generate_name.rb'

class RegistrationUsers
  def initialize(amount)
    @now = 0
    while @now < amount.to_i
      if registration
        print_information
        @now += 1
      end
    end
  end

  private

  def registration
    @reg = Registration.new(generat_data)
    @email = @reg.get_email_on_site("http://www.mohmal.com/ru")
    check_succesful_registration(@reg.registration_on_site("https://dev.by/registration"))
  end

  def generat_data
    gen = GenerateName.new('ru')
    @passwd = gen.password
    [gen.nick_name, gen.password, gen.first_name, gen.last_name]
  end

  def check_succesful_registration(success)
    if success
      @reg.confirm_registration
      true
    else
      false
    end
  end

  def print_information
    puts "Email #{ @now + 1 } user: #{ @email }"
    puts "Passwd #{ @now + 1 } user: #{ @passwd }"
  end
end

RegistrationUsers.new(ARGV[0])





