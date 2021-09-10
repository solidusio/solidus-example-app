if ENV['CLOUDINARY_URL'] || ENV['HEROKU']
  require 'paperclip/cloudinary'

  Paperclip::Attachment.default_options[:storage] = :cloudinary

  Spree::Image.attachment_definitions[:attachment].delete(:url)
  Spree::Image.attachment_definitions[:attachment].delete(:path)
  Spree::Image.attachment_definitions[:attachment].delete(:default_url)
  Spree::Image.attachment_definitions[:attachment][:path] = 'spree/products/:id/:style/:filename'
  Spree::Image.attachment_definitions[:attachment][:cloudinary_url_options] = {
    default: { secure: true }
  }
end
