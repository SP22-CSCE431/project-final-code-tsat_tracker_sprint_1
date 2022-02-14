class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]


  def self.from_google(from_google_params)
    # copy = from_google_params[email]
    # return nil unless copy =~ /@gmail.com || @tamu.edu\z/
    # instead of find or create by just find
    # create_with(from_google_params).find_or_create_by!(from_google_params)
    create_with(from_google_params).find_by! email: from_google_params[:email]

  end

  private
  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name,
      avatar_url: auth.info.image
    }
  end
  
end