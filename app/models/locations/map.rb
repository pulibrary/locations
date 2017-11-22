module Locations
  class Map
    attr_reader :id, :loc, :cn

    def initialize(id: nil, loc: nil, callno: nil)
      @id = id
      @loc = loc
      @cn = callno
    end

    def url
      if locator_libs.include? lib.code
        locator_url
      elsif stackmap_libs.include? lib.code
        stackmap_url
      else
        "https://pulsearch.princeton.edu/requests/#{id}"
      end
    end

    def locator_url
      "https://library.princeton.edu/locator/index.php?loc=#{loc}&id=#{id}"
    end

    def stackmap_url
      stackmap_url = 'https://princeton.stackmap.com'
      URI.encode("#{stackmap_url}/view/?callno=#{callno}&location=#{loc}&library=#{lib.label}")
    end

    def callno
      if by_title_locations.include? loc
        bibrec['title_sort'].first
      else
        cn || bibrec['call_number_browse_s'].first
      end
    end

    # Need to include all non-stackmap libraries here to support the Main Catalog
    # that displays the locator link on EVERY record.
    def locator_libs
      %w(firestone hrc annexa annexb mudd online rare recap)
    end

    def stackmap_libs
      %w(architecture eastasian engineering lewis mendel marquand plasma stokes)
    end

    def closed_stack_reserves
      %w(ueso spir piaprr gstr strp strr pplr scires scigr scilal sar musg musr)
    end

    def by_title_locations
      %w(sciss pplps sprps spiaps)
    end

    def holding_location
      @holding_location ||= Locations::HoldingLocation.find_by(code: loc)
    end

    def bibrec
      @bibrec ||= fetch_bibrec
    end

    def lib
      @lib ||= Locations::Library.find(holding_location.locations_library_id)
    end

    def hours_location
      @hours_location ||= fetch_hours_location
    end

    def valid?
      !holding_location.nil? && (cn || !bibrec.empty?)
    end

    def on_reserve?
      closed_stack_reserves.include? loc
    end

    private

    def fetch_bibrec
      return {} unless id
      url = "https://bibdata.princeton.edu/bibliographic/#{id}/solr"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)
      res.code == '200' ? JSON.parse(res.body) : {}
    end

    def fetch_hours_location
      hours_location_id = holding_location.locations_hours_location_id
      Locations::HoursLocation.find_by(id: hours_location_id)
    end
  end
end
