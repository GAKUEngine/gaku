Paperclip.interpolates(:placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("missing_#{style}.png")
end