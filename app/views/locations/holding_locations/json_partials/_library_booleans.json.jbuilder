Locations::Library.all.each do |library|
  json.set! library.code, holding_location.send("#{library.code}?")
end
