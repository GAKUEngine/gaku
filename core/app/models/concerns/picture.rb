module Picture
  extend ActiveSupport::Concern

  included do
    has_attached_file :picture, styles: { thumb: '256x256>' }, default_url: ':placeholder'
    do_not_validate_attachment_file_type :picture
  end
end
