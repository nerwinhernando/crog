class BlogPost < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content
  validates :title, presence: true
  # validates :body, presence: true
  # validates_presence_of :body, on: :create, message: "can't be blank"
  validates_presence_of :content, on: :create, message: "can't be blank"

  # scope :sorted, -> { order(published_at: :desc, updated_at: :desc)}
  # this
  # scope :sorted, -> { order(Arel.sql("published_at DESC NULLS LAST")).order(updated_at: :desc) }
  # or this
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_last).order(updated_at: :desc)}
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at >= ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end
end
