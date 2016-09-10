require_relative '../spec_helper'

describe I18n do

  before { I18n.load_translations_path File.join(__dir__, '..', 'locales', 'a.yml') }
  before { I18n.load_translations_path File.join(__dir__, '..', 'locales', 'b.yml') }
  before { I18n.locale = :es }

  it { expect(I18n.t :sample).to eq 'ejemplo'}
  it { expect(I18n.t :test).to eq 'prueba'}

end