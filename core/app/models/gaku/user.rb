module Gaku
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

  	#in :accessors should be added all settings that user can set and check againts Preset
    store :settings, :accessors => [:locale]

    attr_accessor :login
    #ActiveRecord::Store accessors can be validated as other model attributes
    # validates :language, :numericality => true

    attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :locale

    before_create :default_language

    validates_presence_of :username

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

    private

    def default_language
      self.settings[:locale] = Gaku::Preset.get('language')
    end

  end
end
