module Locations
  class Map
    attr_accessor :id,:loc

    def initialize(id: nil, loc: nil)
      @locator_url = "http://library.princeton.edu/locator/index.php?"
      @stackmap_url = "http://princeton.stackmap.com/view/?"
      @id ||= id
      @loc ||= loc
    end

    def url
      if is_valid?
        #todo: send requests to unmappable locations here "https://pulsearch.princeton.edu/requests/#{self.id}"
        if self.lib.code == 'firestone'
          @locator_url + "loc=" + self.loc + "&id=" + self.id
        else
          callno = self.bibrec['call_number_display'].first.gsub(/\s/,'+') # <== problem code on rails server
          @stackmap_url + "callno=" + callno  + "&location=" + self.loc + "&library=" + self.lib.label.gsub(/\s/,'+')
        end
      else
        nil
      end
    end

    def holding_location
      @holding_location ||= set_holding_location(self.loc)
    end

    def bibrec
      @bibrec ||= set_bibrec(self.id)
    end

    def lib
      @lib ||= set_lib(self.holding_location.locations_library_id)
    end

    def is_valid?
      if !self.holding_location.nil? && !self.bibrec.nil?
        true
      else
        false
      end
    end

    private

    def set_holding_location(loc_code)
      Locations::HoldingLocation.find_by(code: loc_code)
    end

    def set_lib(library_id)
      Locations::Library.find(library_id)
    end

    def set_bibrec(bibid)
      url = "https://bibdata.princeton.edu/bibliographic/#{self.id}/solr"
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
