module Gaku
  class User < ActiveRecord::Base

    has_many :user_roles
    has_many :roles, through: :user_roles

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    store :settings, accessors: [:locale]

    attr_accessor :login

    # attr_accessible :login, :username, :email,
    #                 :password, :password_confirmation,
    #                 :remember_me, :locale, :role_ids

    before_create :default_language

    validates_presence_of :username, :email
    validates_uniqueness_of :username, :email
    validates_presence_of :password, :password_confirmation, on: :create

    roles_table_name = Gaku::Role.table_name

    scope :admin, -> { includes(:roles).where("#{roles_table_name}.name" => "admin") }

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
      else
        where(conditions).first
      end
    end

    def has_role?(role_sym)
      roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

    def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
    end

    private

    def default_language
      self.settings[:locale] = Gaku::Preset.get('language')
    end

  end
end
