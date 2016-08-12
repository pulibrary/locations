module Locations
  class Map
    attr_accessor :id,:loc

    def initialize(id: nil, loc: nil)
      @id ||= id
      @loc ||= loc
    end

    def url
        return self.locator_url if self.locator_url
        return self.stackmap_url if self.stackmap_url
        "https://pulsearch.princeton.edu/requests/#{self.id}"
    end

    def locator_url
      return false unless self.locator_libs.include? self.lib.code
      "http://library.princeton.edu/locator/index.php?" + "loc=" + self.loc + "&id=" + self.id
    end

    def stackmap_url
      return false unless self.stackmap_libs.include? self.lib.code
      if self.by_title_locations.include? self.loc
        callno = self.bibrec['title_sort'].first
      else
        callno = self.bibrec['call_number_display'].first
      end
      URI.encode("http://princeton.stackmap.com/view/?callno=" + callno  + "&location=" + self.loc + "&library=" + self.lib.label)
    end

    def locator_libs
      ['firestone']
    end

    def stackmap_libs
      ['architecture','eastasian','engineering','lewis','mendel','marquand','plasma','stokes']
    end

    def closed_stack_reserves
      ['ueso','spir','piaprr','gstr','strp','strr','pplr','scires','scigr','scilal','sar','musg','musr']
    end

    def by_title_locations
      ['sciss','pplps']
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

    def on_reserve?
      if self.closed_stack_reserves.include? self.loc
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
      end

    end

  end
end
