require_dependency "locations/application_controller"

module Locations
  class MapController < ApplicationController

    def index

        if params[:loc] && params[:id]
          holding_location = get_holding_location(params[:loc])
          bibrec = get_bibrec(params[:id])
          if !holding_location.nil? && !bibrec.nil?
            lib = get_lib(holding_location.locations_library_id)
            if lib.code == 'firestone'
              redirect_to  "http://library.princeton.edu/locator/index.php?loc=" + params[:loc]+ "&id=" + params[:id]
            else
              redirect_to  "http://princeton.stackmap.com/view/?callno=" + bibrec['call_number_display'].first.gsub!(/\s/,'+') + "&location=" + params[:loc] + "&library=" + lib.label.gsub!(/\s/,'+')
            end
          else
            render plain: "Invalid loc code or bibid", status: 404
          end
        else
          render plain: "No loc code or bibid supplied.", status: 404
        end

    end

    private

    def get_holding_location(loc_code)
      holding_location = Locations::HoldingLocation.find_by(code: loc_code)
    end

    def get_lib(lib_id)
      Locations::Library.find(lib_id)
    end

    def get_bibrec(bibid)
      url = 'https://bibdata.princeton.edu/bibliographic/' + bibid + '/solr'

      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)

      if res.code == '200'
        JSON.parse(res.body)
      else
        nil
      end

    end

  end
end
