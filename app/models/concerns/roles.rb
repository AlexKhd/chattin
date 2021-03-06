module Concerns
  module Roles
    extend ActiveSupport::Concern

    [:user?, :admin?, :family?].each do |method_name|
      define_method method_name do
        self.role == method_name.to_s.chomp('?')
      end
    end
  end
end
