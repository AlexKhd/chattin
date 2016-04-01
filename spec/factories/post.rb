FactoryGirl.define do
  factory :post do
    caption "A caption"
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'images', 'post_image.jpg'), 'image/jpg' ) }
    user
  end
end
