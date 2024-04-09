class Feature < ApplicationRecord
    validates :usgs_id, presence: true, uniqueness: true
    validates :title, presence: true
    validates :url, presence: true
    validates :place, presence: true
    validates :mag_type, presence: true
    validates :longitude, presence: true, numericality: true
    validates :latitude, presence: true, numericality: true
    has_many :comments, dependent: :destroy
end
