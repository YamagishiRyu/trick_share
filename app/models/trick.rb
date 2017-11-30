class Trick < ApplicationRecord
  # association
  belongs_to :contributor
  has_many :favorites, dependent: :destroy
  has_many :liked_contributors, through: :favorites, source: :contributor
  has_many :comments
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag
  has_many :need_tools, dependent: :destroy
  has_many :tools, through: :need_tools, source: :tool

  # order
  default_scope -> { order(created_at: :desc) }

  # validation
  validates :contributor_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
  validates :duration, presence: true, numericality: :only_integer

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # destroy old taggings
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # create new taggings
    new_tags.each do |new_name|
      tagging_tag = Tag.find_or_create_by(name: new_name)
      self.tags << tagging_tag
    end
  end

  def save_tools(tools)
    current_tools = self.tools.pluck(:name) unless self.tools.nil?
    old_tools = current_tools - tools
    new_tools = tools - current_tools

    # destroy old need_tools
    old_tools.each do |old_name|
      self.tools.delete Tool.find_by(name: old_name)
    end

    # create new need_tools
    new_tools.each do |new_name|
      needed_tool = Tool.find_or_create_by(name: new_name)
      self.tools << needed_tool
    end
  end
end
