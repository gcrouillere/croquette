class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :confirmation, :info, :contact, :google906057532e2dbb7e, :robots, :legal, :cgv, :garde_animaux_domicile]

  def home
    @dev_redirection = "http://www.guillaumecrouillere.fr"
    @ceramiques = Ceramique.order(position: :asc).order(updated_at: :desc).first(3)
    render "home_#{@active_theme.name}"
  end

  def confirmation
    render "confirmation_#{@active_theme.name}"
  end

  def info
    @dev_redirection = "http://www.guillaumecrouillere.fr"
    render "info_#{@active_theme.name}"
  end

  def contact
    @dev_redirection = "http://www.guillaumecrouillere.fr"
    render "contact_#{@active_theme.name}"
  end

  def garde_animaux_domicile
    @user = User.new
  end

  def legal
    @dev_redirection = "http://www.guillaumecrouillere.fr"
  end

  def cgv
    @dev_redirection = "http://www.guillaumecrouillere.fr"
  end

  def google906057532e2dbb7e
  end

  def robots
    render 'pages/robots.txt.erb'
    expires_in 6.hours, public: true
  end

end
