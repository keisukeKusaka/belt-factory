FactoryBot.define do
  factory :evaluation_image do
    image       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/kuroneko.jpg')) }
    evaluation_datum
  end
end
