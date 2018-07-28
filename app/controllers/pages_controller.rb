class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :confirmation, :info, :contact, :google906057532e2dbb7e, :robots, :legal, :cgv, :garde_animaux_domicile]

  def home
    @dev_redirection = "https://www.creermonecommerce.fr/"
    @ceramiques = Ceramique.last(3)
    render "home_#{@active_theme.name}"
  end

  def confirmation
    render "confirmation_#{@active_theme.name}"
  end

  def info
    @dev_redirection = "https://www.creermonecommerce.fr/#anchor-info"
    render "info_#{@active_theme.name}"
  end

  def contact
    @dev_redirection = "https://www.creermonecommerce.fr/produits"
    render "contact_#{@active_theme.name}"
  end

  def garde_animaux_domicile
    @user = User.new
  end

  def legal
    @dev_redirection = "https://www.creermonecommerce.fr/produits"
  end

  def cgv
    @dev_redirection = "https://www.creermonecommerce.fr/produits"
  end

  def google906057532e2dbb7e
  end

  def robots
    render 'pages/robots.txt.erb'
    expires_in 6.hours, public: true
  end

end
