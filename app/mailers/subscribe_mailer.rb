class SubscribeMailer < ApplicationMailer

  def subscribe(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, subject: "Inscription à la newsletter")
  end

  def web_message(user, admin)
    @user = user
    @admin = admin
    mail(to: @admin.email, subject: "Message depuis la boutique en ligne")
  end

  def garde_animaux_message_admin(admin)
    @admin = admin
    mail(to: @admin.email, subject: "Demande de garde à domicile")
  end

  def garde_animaux_message_user(user)
    @user = user
    mail(to: @user.email, subject: "Demande de garde à domicile")
  end

end
