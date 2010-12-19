module Chingu
  class Animation
    def media_path(file)
      "#{ROOT}/media/gfx/#{file}"
    end
  end
end

module Gosu
  class Image
    def self.autoload(name)
      ret = (path = find_file(name)) ? Gosu::Image.new($window, path, true) : nil
      raise "Can't load image \"#{name}\"" if ret.nil?
      return ret
    end
  end
end