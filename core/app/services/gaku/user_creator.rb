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
      @user.settings[:locale] = if Preset.active.nil?
                                  'en'
                                else
                                  Preset.active.locale['language']
                                end
    end
  end
end
