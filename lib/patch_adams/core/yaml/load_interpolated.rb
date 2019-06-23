require 'yaml'

module YAML
  def self.load_interpolated(filename)
    YAML.load(ERB.new(File.read(filename)).result)
  end
end