module Lolita
  module Mobilly
    module Billing
      def self.included(base)
        base.has_many :mobilly_transactions, :as => :paymentable, :class_name => "Lolita::Mobilly::Transaction", :dependent => :destroy
        base.extend ClassMethods
        base.class_eval do
          # returns true if exists transaction with status 'completed'
          # and updates status if needed
          def paid?
            self.mobilly_transactions.count(:conditions => {:status => 'completed', :transaction_code => 1}) >= 1
          end

          def mobilly_error_message
            if !mobilly_transactions.empty? && mobilly_transactions.last.transaction_code
              I18n.t("mobilly.response.code_#{mobilly_transactions.last.transaction_code}", :default => I18n.t('mobilly.unknown_error'))
            end
          end
        end
      end

      module ClassMethods
      end
    end
  end
end
