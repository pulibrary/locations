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
        if self.locator_libs.include? self.lib.code
          @locator_url + "loc=" + self.loc + "&id=" + self.id
        elsif self.stackmap_libs.include? self.lib.code
          if !self.closed_stack_reserves.include? self.loc
            if self.by_title_locations.include? self.loc
              callno = self.bibrec['title_sort'].first
            else
              callno = self.bibrec['call_number_display'].first
            end
            URI.encode(@stackmap_url + "callno=" + callno  + "&location=" + self.loc + "&library=" + self.lib.label)
          else
            "This item is currently in a reserve location please see the circulation desk at the #{self.lib.label} to get an available copy."
          end
        else
          "https://pulsearch.princeton.edu/requests/#{self.id}"
        end
      else
        nil
      end
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
