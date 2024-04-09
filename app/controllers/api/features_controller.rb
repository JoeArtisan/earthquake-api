module Api
  class FeaturesController < ApplicationController

    def index
      features = Feature.all

      if params[:mag_type].present?
        mag_types = params[:mag_type].split(',')
        features = features.where(mag_type: mag_types)
      end

      per_page = params[:per_page]&.to_i || 10
      page = params[:page]&.to_i || 1
      total = features.count
      features = features.limit(per_page).offset((page - 1) * per_page)

      formatted_features = features.map do |feature|
        {
          id: feature.id,
          type: 'feature',
          attributes: {
            external_id: feature.usgs_id,
            magnitude: feature.mag,
            place: feature.place,
            time: Time.at(feature.time / 1000).strftime("%d/%m/%Y %H:%M"), 
            tsunami: feature.tsunami,
            mag_type: feature.mag_type,
            title: feature.title,
            coordinates: {
              longitude: feature.longitude,
              latitude: feature.latitude
            }
          },
          links: {
            external_url: feature.url
          }
        }
      end

      render json: {
        data: formatted_features,
        pagination: {
          current_page: page,
          total: total,
          per_page: per_page
        }
      }
    end
  end
end