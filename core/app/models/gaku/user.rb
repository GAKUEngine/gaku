module Gaku
  class User < ActiveRecord::Base

    has_many :user_roles
    has_many :roles, through: :user_roles

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    store :settings, accessors: [:locale]

    attr_accessor :login

    before_create :default_language

    validates :username, presence: true, uniqueness: true

    roles_table_name = Role.table_name

    scope :admin, -> { includes(:roles).where("#{roles_table_name}.name" => 'admin') }

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
      else
        where(conditions).first
      end
    end

    def has_role?(role_sym)
      roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

    def role?(role)
      !!self.roles.find_by_name(role.to_s.camelize)
    end

    private

    def default_language
      settings[:locale] = Preset.get('language')
    end

  end
end
