FactoryBot.define do
  factory :inspection_image do
    image       { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/kuroneko.jpg')) }
    inspection_datum
  end
end
