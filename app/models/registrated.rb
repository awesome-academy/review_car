class Registrated < ApplicationRecord
	has_many :car_registrateds, dependent: :destroy
	has_many :cars, through: :car_registrateds
	has_many :registrations, through: :car_registrateds, dependent: :destroy
	validates :car_ids, presence: true

end
