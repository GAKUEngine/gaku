module Gaku
  class User < ActiveRecord::Base
    has_many :user_roles
    has_many :roles, through: :user_roles

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    store :settings, accessors: [:locale]

    attr_accessor :login

    validates :username, presence: true, uniqueness: true

    roles_table_name = Role.table_name

    scope :admin, -> { includes(:roles).where("#{roles_table_name}.name" => 'Admin') }

    def student_selection
      hashes = $redis.lrange(:student_selection, 0, -1)
      hashes.map! { |x| JSON.parse(x) }
    end

    def clear_student_selection
      $redis.del(:student_selection)
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
      roles.where(name: role.to_s.camelize).any?
    end
  end
end
