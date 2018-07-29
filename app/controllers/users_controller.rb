class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:subscribe, :garde_animaux_domicile_user_create]

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to request.referrer
  end

  def subscribe
    unless session[:email]
      if Regexp.new('\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,}\z').match(params[:user][:email]) && params[:user][:first_name] != "" && params[:user][:tracking] != ""
        @user = User.user_subscribe(user_params)
        if request.referrer.match("contact")
          SubscribeMailer.web_message(@user, @admin).deliver_now
        else
          SubscribeMailer.subscribe(@user, @admin).deliver_now
        end
        session[:email] = params[:user][:email]
        flash[:notice] = t(:message_thank)
        redirect_to request.referrer
      else
        flash[:alert] = t(:incorrect_fields)
        redirect_to request.referrer
      end
    end
  end

  def garde_animaux_domicile_user_create
    @user = User.user_garde_domicile(user_params)
    if @user.save && params[:user][:tel].present? && params[:user][:tracking].present?
      SubscribeMailer.garde_animaux_message_user(@user, @admin).deliver_now
      SubscribeMailer.garde_animaux_message_admin(@user, @admin).deliver_now
      flash[:notice] = t(:message_thank_garde)
      redirect_to garde_animaux_domicile_path
    else
      flash[:alert] = "La demande ne peut être envoyée. Veuillez corriger les erreurs dans le formulaire ci-dessous."
      garde_user_errors_management
      render 'pages/garde_animaux_domicile'
    end
  end

  private

   def user_params
    params.require(:user).permit(
      :id,
      :first_name,
      :last_name,
      :email,
      :adress,
      :zip_code,
      :city,
      :tel,
      :provider,
      :tracking,
      :uid,
      :facebook_picture_url,
      :token,
      :token_expiry,
      :productphoto,
      :avatarphoto,
      :cityphoto,
      :info2photo,
      :info1photo,
      :gardephoto,
      :productphotomobile,
      :lessonphoto,
      :logophoto,
      :darktheme1photo,
      :darktheme2photo,
      :darktheme3photo,
      :darktheme4photo,
      :country,
      homerightphotos: []
    )
  end

  def garde_user_errors_management
    unless Regexp.new('^(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}$').match(params[:user][:tel])
      @user.errors[:tel] << "format incorrect"
    end
    unless params[:user][:tracking].present?
      @user.errors[:tracking] << "doit être rempli(e)"
    end
  end
end
