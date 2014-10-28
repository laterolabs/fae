module Fae
  class Image < ActiveRecord::Base

    attr_accessor :redirect
    mount_uploader :asset, Fae::ImageUploader

    validate :asset_exists_for_options

    belongs_to :imageable, polymorphic: true, touch: true

    def asset_exists_for_options
      errors.add(:asset, "can't be empty") if imageable_type == "Fae::Option" && attached_as == "logo" && asset.blank?
    end

  private

    # def crop_image
    #   asset.recreate_versions! if crop_x_changed? or crop_y_changed? or crop_x2_changed? or crop_y2_changed?
    # end

    class << self

      # all image info is set here, yes this will get big, but it's best to keep this stuff in one place!
      def sizing_info
        info = {
          hero_image: {
            min_width: 1500,
            max_width: 1500,
            min_height: 0,
            max_height: 0,
            notes: 'Any special notations go here. All image info is defined in one place: the image model'
          },
          large_ad: {
            min_width: 720,
            max_width: 720,
            min_height: 0,
            max_height: 0,
            notes: nil
          },
          small_ad: {
            min_width: 340,
            max_width: 340,
            min_height: 0,
            max_height: 0,
            notes: nil
          },
          gallery_image: {
            min_width: 1100,
            max_width: 1100,
            min_height: 0,
            max_height: 0,
            notes: nil
          }
        }
      end

    end

  end
end