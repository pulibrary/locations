module Locations
  class Map
    include ActiveModel::Model
    validates :loc, presence: true

    def initialize(params = {})
      @@locator_url = "http://library.princeton.edu/locator/index.php?"
      @@stackmap_url = "http://princeton.stackmap.com/view/?"
      @params = params
    end

    def url
      if @params[:loc] && @params[:id]
        holding_location = get_holding_location(@params[:loc])
        bibrec = get_bibrec(@params[:id])
        if !holding_location.nil? && !bibrec.nil?
          lib = get_lib(holding_location.locations_library_id)
          if !holding_location.open
            'https://pulsearch.princeton.edu/requests/' + @params[:id]
          elsif lib.code == 'firestone'
            @@locator_url + "loc=" + @params[:loc]+ "&id=" + @params[:id]
          else
            @@stackmap_url + "callno=" + bibrec['call_number_display'].first.gsub!(/\s/,'+') + "&location=" + @params[:loc] + "&library=" + lib.label.gsub!(/\s/,'+')
          end
        else
          nil
        end
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
