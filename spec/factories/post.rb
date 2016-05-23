FactoryGirl.define do
  factory :post do
    caption Faker::Lorem.sentence
    image do
      Rack::Test::UploadedFile.new(Rails.root.join(
                                     'spec',
                                     'support',
                                     'images',
                                     'post_image.jpg'), 'image/jpg')
    end
    user
  end
end
