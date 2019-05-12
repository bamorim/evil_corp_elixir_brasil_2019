defmodule EvilCorp.Identity.UserEmail do
  import Bamboo.Email

  def welcome_email(email, name) do
    new_email(
      to: {name, email},
      from: "evilcorp@evilcorp.com",
      subject: "Welcome to EvilCorp",
      text_body: "Welcome to EvilCorp, #{name}",
      html_body: "Welcome to <b>EvilCorp</b>, #{name}"
    )
  end
end
