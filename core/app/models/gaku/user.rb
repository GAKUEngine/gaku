module Gaku
  class User < ActiveRecord::Base
    has_many :user_roles
    has_many :roles, through: :user_roles

    has_one :teacher

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    store :settings, accessors: [:locale]

    attr_accessor :login

    validates :username, presence: true, uniqueness: true

    roles_table_name = Role.table_name

    scope :admin, -> { includes(:roles).where("#{roles_table_name}.name" => 'Admin') }

    scope :enabled, -> do
      where("disabled_until <= ?", Date.today)
      .or(where(disabled_until: nil, disabled: false))
    end

    def to_s
      username
    end

    # Override Devise::Models::Authenticatable#find_first_by_auth_conditions
    # so login can be authenticated against username or email
    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login)
      if login
        where(conditions).where(
          ['lower(username) = :value OR lower(email) = :value',
           { value: login.downcase }]
        ).first
      else
        where(conditions).first
      end
    end

    def role?(role)
      roles.exists?(name: role)
    end

  end
end
