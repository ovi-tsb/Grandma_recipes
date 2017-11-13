class Recipe < ApplicationRecord
  belongs_to :user

  has_many :ingredients
  has_many :directions
  #accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes| attributes['name'].blank? }, allow_destroy: true
  #accepts_nested_attributes_for :directions, reject_if: proc { |attributes| attributes['step'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true
  
  validates :title, :description, presence: true
  
  has_attached_file :image, styles: { medium: "400x400>" },
    storage: :s3,
    s3_host_name: 's3-us-east-2.amazonaws.com',
    s3_credentials: {
      bucket: ENV.fetch('S3_BUCKET_NAME'),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    },
    s3_region: ENV.fetch('AWS_REGION'),
    :url => "/assets/:basename.:extension",
    :path => ":rails_root/app/assets/images/:basename.:extension"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
