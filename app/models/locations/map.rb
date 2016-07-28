module Locations
  class Map
    include ActiveModel::Model

    def initialize(params = {})
      @@locator_url = "http://library.princeton.edu/locator/index.php?"
      @@stackmap_url = "http://princeton.stackmap.com/view/?"
      @params = params
      @holding_location = set_holding_location(@params[:loc])
      @bibrec = set_bibrec(@params[:id])
      @lib = set_lib(@holding_location.locations_library_id)
      @valid = is_valid
    end

    def url
        if @valid
          if !@holding_location.open
            'https://pulsearch.princeton.edu/requests/' + @params[:id]
          elsif @lib.code == 'firestone'
            @@locator_url + "loc=" + @params[:loc]+ "&id=" + @params[:id]
          else
            callno = @bibrec['call_number_display'].first.gsub(/\s/,'+') # <== problem code on rails server
            @@stackmap_url + "callno=" + callno  + "&location=" + @params[:loc] + "&library=" + @lib.label.gsub!(/\s/,'+')
          end
        else
          nil
        end
    end

    def loc
      @params[:loc]
    end

    def id
      @params[:id]
    end

    def holding_location
      @holding_location
    end

    def bibrec
      @bibrec
    end

    def lib
      @lib
    end

    def valid
      @valid
    end

    private

    def is_valid
      if !@holding_location.nil? && !@bibrec.nil?
        true
      else
        false
      end
    end

    def set_holding_location(loc_code)
      @holding_location = Locations::HoldingLocation.find_by(code: loc_code)
    end

    def set_lib(lib_id)
      @lib = Locations::Library.find(lib_id)
    end

    def set_bibrec(bibid)
      url = 'https://bibdata.princeton.edu/bibliographic/' + bibid + '/solr'
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)

      if res.code == '200'
        @bibrec = JSON.parse(res.body)
      else
        @bibrec = nil
      end

    end

  end
end
