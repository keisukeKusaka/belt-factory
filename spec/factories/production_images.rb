FactoryBot.define do
  factory :production_image do
    image       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/kuroneko.jpg')) }
    production_datum
  end
end
