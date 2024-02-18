class OrderDetail < ApplicationRecord
  enum making_status: { not_ready_for_production: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }
  
end