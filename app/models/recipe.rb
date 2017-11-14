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
    :url => "/assets/:basename.:extension",
    :path => ":rails_root/app/app/assets/images/:basename.:extension"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
