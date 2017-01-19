require_relative '../spec_helper'

describe YAML do
  it { expect(YAML.load_interpolated 'spec/data/sample.yml').to json_like production: {port: 1045} }
end