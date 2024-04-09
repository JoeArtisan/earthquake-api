namespace :usgs_gov do
  desc "Get data from USGS.GOV"
  task get: :environment do
    begin
      puts "#{Time.now().to_s} - Consulting earthquake.usgs.gov"
      url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
      response = HTTParty.get(url)

      if response.success?
        data = JSON.parse(response.body)
        puts "#{Time.now().to_s} - #{data['features'].length()} events have been found."        
        x = 0

        data['features'].each do |feature|
          properties = feature['properties']
          coordinates = feature['geometry']['coordinates']

          # Validar requeridos no nulos
          next if [properties['title'], properties['url'], properties['place'], properties['magType'], coordinates[0], coordinates[1]].any?(&:nil?)
          # Validar rangos
          next unless properties['mag'].between?(-1.0, 10.0) && coordinates[1].between?(-90.0, 90.0) && coordinates[0].between?(-180.0, 180.0)
          # Evitar duplicados
          next if Feature.exists?(usgs_id: feature['id'])

          # Persistir los datos
          Feature.create(
            usgs_id: feature['id'],
            mag: properties['mag'],
            place: properties['place'],
            time: properties['time'],
            url: properties['url'],
            tsunami: properties['tsunami'],
            mag_type: properties['magType'],
            title: properties['title'],
            longitude: coordinates[0],
            latitude: coordinates[1]
          )
          x += 1
        end
      
        puts "#{Time.now().to_s} - Task completed successfully."
        puts "#{Time.now().to_s} - #{x} events were included."
      else
        puts "#{Time.now().to_s} - Error obtaining data. Status code: #{response.code}"
      end
      rescue StandardError => e
        puts "#{Time.now().to_s} - Error: #{e.message}"
    end
  end
end