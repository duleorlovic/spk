require 'i18n'

LOCALE = :sr

module Jekyll
  module I18nFilter
    # {{ post.date | localize: ":short" }}
    # {{ post.date | localize: "%d.%m.$Y"}
    def localize(input, format=nil)
      load_translations
      format = (format=~ /^:(\w+)/) ? $1.to_sym : format
      I18n.l input, :format => format
    end
    def translate(input)
      load_translations
      I18n.t input
    end
    def load_translations
      unless I18n::backend.instance_variable_get(:@translations)
        I18n.backend.load_translations Dir[File.join(File.dirname(__FILE__),'../_locales/*.yml')]
        I18n.locale = LOCALE
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::I18nFilter)
