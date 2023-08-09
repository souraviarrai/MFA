module Services

  class OutletIndex
    attr_accessor :params
    OUTLET_STATUSES = ['accepted','pending']
    def initialize(params)
      @params = params
    end
    def call
      if params[:params][:status].present?
        accepted_or_pending_outlets(params[:params][:status])
      else
        all_outlets
      end
    end

    private
    def accepted_or_pending_outlets(status)
      if valid_status?(status)
        { json: Outlet.where(status: status) , status: 200 }
      else
        { json: 'invalid status', status: 400 }
      end
    end
    def all_outlets
      { json: Outlet.all, status: 200 }
    end

    def valid_status?(status)
      OUTLET_STATUSES.include?(status)
    end
  end
end

