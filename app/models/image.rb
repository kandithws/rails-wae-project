class Image < ApplicationRecord
  # http://www.austinstory.com/adding-nested-image-attributes-to-rails-4-app-using-paperclip/
  belongs_to :imageable, :polymorphic => true, optional: true
  has_attached_file :content, :styles=>{:medium => "300x300>",
                                        :thumb => "100x100>",
                                        :large =>   "500x500>", :xlarge =>   "640x480>"}
  validates_attachment_content_type :content, :content_type => %w(image/jpeg image/jpg image/png)
end
