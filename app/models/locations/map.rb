module Locations
  class Map
    attr_reader :id, :loc

    def initialize(id: nil, loc: nil)
      @id = id
      @loc = loc
    end

    def url
      return locator_url if locator_url
      return stackmap_url if stackmap_url
      "https://pulsearch.princeton.edu/requests/#{id}"
    end

    def locator_url
      return false unless locator_libs.include? lib.code
      "http://library.princeton.edu/locator/index.php?loc=#{loc}&id=#{id}"
    end

    def stackmap_url
      return false unless stackmap_libs.include? lib.code
      stackmap_url = 'http://princeton.stackmap.com'
      URI.encode("#{stackmap_url}/view/?callno=#{callno}&location=#{loc}&library=#{lib.label}")
    end

    def callno
      return bibrec['title_sort'].first if by_title_locations.include? loc
      bibrec['call_number_display'].first
    end

    def locator_libs
      ['firestone']
    end

    def stackmap_libs
      %w(architecture eastasian engineering lewis mendel marquand plasma stokes)
    end

    def closed_stack_reserves
      %w(ueso spir piaprr gstr strp strr pplr scires scigr scilal sar musg musr)
    end

    def by_title_locations
      %w(sciss pplps)
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
      return true if !holding_location.nil? && !bibrec.nil?
      false
    end

    def on_reserve?
      return true if closed_stack_reserves.include? loc
      false
    end

    private

    def fetch_bibrec
      url = "https://bibdata.princeton.edu/bibliographic/#{id}/solr"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      res = http.request(request)
      res.code == '200' ? JSON.parse(res.body) : ''
    end

    def fetch_hours_location
      hours_location_id = holding_location.locations_hours_location_id
      Locations::HoursLocation.find_by(id: hours_location_id)
    end
  end
end
