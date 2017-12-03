require 'securerandom'
require 'translit'
require 'faker'

class GenerateName
  attr_reader :first_name
  attr_reader :last_name
  attr_reader :password
  attr_reader :nick_name

  def initialize(loc)
    gen_name(loc)
    gen_passwd
    gen_nickname
  end

  private

  def gen_name(loc)
    Faker::Config.locale = loc
    if loc == 'ru'
      @first_name = Faker::Name.male_first_name
      @last_name = Faker::Name.male_last_name
    end
    if loc == 'en'
      @first_name = Faker::Name.first_name
      @last_name = Faker::Name.last_name
    end
  end

  def gen_passwd
    @password = SecureRandom.base64(9)
  end

  def gen_nickname
    first = Translit.convert(@first_name, :english)
    last = Translit.convert(@last_name, :english).delete "'"
    @nick_name = first[0] + "." + last
  end
end