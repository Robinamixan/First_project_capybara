require 'capybara'

class Registration

  def initialize(gen_information)
    @session = Capybara::Session.new(:selenium_chrome)
    @url_email_site
    @email
    @nickname = gen_information[0]
    @password = gen_information[1]
    @first_name = gen_information[2]
    @last_name = gen_information[3]
  end

  def get_email_on_site(url_mail_site)
    @session.visit url_mail_site
    create_email
    @email = get_email_from_site
  end

  def registration_on_site(url_site_registration)
    @session.visit url_site_registration
    fill_fields_registration
    click_confirm_registration
    check_succesful
  end

  def confirm_registration
    sleep(0.5)
    @session.visit @url_email_site
    choose_message
    sleep(2)
  end

  private

  def create_email
    sleep(0.5)
    @session.find("#choose").click
    input_text('name', @nickname)
    @session.find("#next").click
    @session.find("#create").click
  end

  def get_email_from_site
    @url_email_site = @session.current_url
    @session.find("#email .email").text
  end

  def fill_fields_registration
    @session.find("#user_username").click
    fill_nick_email_fields
    fill_password_fields
    fill_person_data_fields
  end

  def fill_nick_email_fields
    input_text("user_username", @nickname)
    input_text("user_email", @email)
  end

  def fill_password_fields
    input_text("user_password", @password)
    input_text("user_password_confirmation", @password)
  end

  def fill_person_data_fields
    input_text("user_first_name", @first_name)
    input_text("user_last_name", @last_name)
  end

  def click_confirm_registration
    @session.find('[for=user_agreement]').click
    @session.find('input[name="commit"]').click
  end

  def check_succesful
    if !@session.has_css?(".errors")
      true
    else
      false
    end
  end

  def choose_message
    sleep(1.5)
    @session.find("a", :text => /\AПодтверждение аккаунта\z/).click
    sleep(1.5)
    @session.within_frame(:xpath, "//div/div/div/div/div/iframe") do
      @session.find("a", :text => /\Aподтвердить\z/).click
    end
  end

  def input_text(field, name)
    field = @session.find_field field
    sleep(0.2)
    field.set(name)
  end
end