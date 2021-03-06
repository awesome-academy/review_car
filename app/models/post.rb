class Post < ApplicationRecord
	mount_uploader :video, VideoUploader
	belongs_to :user
	has_many :follows, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :reports, dependent: :destroy
	has_one_attached :image
	scope :order_by_time,->{ order(created_at: :desc) }
	validates :user_id, presence: true
	validates :content, presence: true
	validates :title, presence: true
	validates :image,content_type: { in: %w[image/jpeg image/gif image/png],
										message: "must be a valid image format" },
										size:
									{ less_than: 5.megabytes,
										message: "should be less than 5MB" }, presence: true
	enum status: [:init, :rejected, :accepted]	

	enum brand: [:other, :mercedes, :ferrari, :lamborghini, :porsche, :audi, :bmw, :volkswagen]								

	def feed_comment
		self.comments
	end
	def display_image
		image.variant(resize_to_limit: [300,300])
	end
end
