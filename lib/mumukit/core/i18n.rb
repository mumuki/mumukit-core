require 'i18n'
require 'i18n/backend/fallbacks'

module I18n
  def self.load_translations_path(path)
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path += Dir[path]

    I18n.backend.load_translations
  end
end