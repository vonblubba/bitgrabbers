class ScreenshotUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  process :watermark
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [80, 50]
    process :quality => 60
  end

  version :big_thumb do
    # resize and crop to 400x265
    process resize_to_fit: [nil, 265]
    process center_crop: ['400']
    process :quality => 65
  end

  version :low_quality do
    process resize_to_fit: [1200, nil]
    process :quality => 85
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{model.game.slug}-#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

  def center_crop(width)
    manipulate! do |img|
      semi_extra = ((get_dimensions[0] - width.to_i) / 2).round
      img.shave("#{semi_extra}x0")
      img
    end
  end

  def get_dimensions
    if file && model
      img = MiniMagick::Image.open(file.file)
      [img.width, img.height]
    end
  end

  def watermark
    second_image = MiniMagick::Image.open("#{Rails.root.join('app', 'assets', 'images', 'watermark.png')}")
    manipulate! do |img|
      result = img.composite(second_image) do |c|
        c.compose "Over"    # OverCompositeOp
        c.gravity "Southeast"
      end
      result
    end
  end
end
