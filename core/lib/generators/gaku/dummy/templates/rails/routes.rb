Rails.application.routes.draw do
  <%= 'mount Gaku::Core::Engine => "/"' if defined?(Gaku::Core) %>
end
