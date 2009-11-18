# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class OrdersTrackerExtension < Spree::Extension
  version "1.0"
  description "Let users track orders by order number and billing zipcode"
  url "http://github.com/calas/spree-orders-tracker"

  def activate
    Order.class_eval do
      def self.find_for_tracking(number=nil, zipcode=nil)
        return nil if number.blank? or zipcode.blank?
        find_by_number(number, :include => :bill_address,
                       :conditions => ["addresses.zipcode = ?", zipcode])
      end
    end
  end
end
