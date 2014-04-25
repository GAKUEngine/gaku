module Gaku
  class UserCreator
    def initialize(params = {})
      @user = User.new(params)
      set_default_language
    end

    def save
      @user.save
    end

    def save!
      @user.save!
    end

    def get_user
      @user
    end

    private

    def set_default_language
      if Preset.active.nil?
        get_user.settings[:locale] = 'en'
      else
        get_user.settings[:locale] = Preset.active.locale['language']
      end
    end
  end
end
