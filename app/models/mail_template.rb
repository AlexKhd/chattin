class MailTemplate < ActiveRecord::Base
  validates :body, :description, presence: true
  validates :format, inclusion: Mime::SET.symbols.map(&:to_s)
  validates :locale, inclusion: I18n.available_locales.map(&:to_s)
  validates :handler, inclusion: ActionView::Template::Handlers.extensions.map(&:to_s)
end
