require 'administrate/field/base'
require 'rails'

module Administrate
  module Field
    class AddressLatLng < Base
      class Engine < ::Rails::Engine
        initializer 'administrate-field-address_lat_lng.add_assets' do |app|
          if app.config.respond_to? :assets
            app.config.assets.precompile << %w(address_lat_lng.css)
          end

          if defined?(Administrate::Engine)
            Administrate::Engine.add_stylesheet 'address_lat_lng.css'
          end
        end
      end

      # True if the :lat option has been provided, or field is called :lat
      def lat?
        options.fetch(:lat, attribute == :lat)
      end

      # True if the :lng option has been provided, or field is called :lng
      def lng?
        options.fetch(:lng, attribute == :lng)
      end

      def address?
        options.fetch(:address, attribute == :address)
      end

      # Return wether or not search should be enabled (defaults to true)
      def search?
        options.fetch(:search, true) && google_api_key.present?
      end

      # Get Google API Key. How to obtain one: https://developers.google.com/maps/documentation/javascript/get-api-key
      def google_api_key
        options.fetch(:google_api_key, nil)
      end

      # Returns :lat or :lng depending on which type this is
      def which
        lat? ? :lat : lng? ? :lng : :address
      end

      # Returns the initial co-ordinates of blank maps (defaults to Leeds, UK)
      def initial
        options.fetch(:initial, [53.8003,-1.5519])
      end

      # Returns the initial zoom level for maps (defaults to 11)
      def zoom
        options.fetch(:zoom, 11)
      end

      def to_s
        data
      end
    end
  end
end
