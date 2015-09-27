# Scaffolding generated by Casein v5.1.1.5

module Casein
  class PaymentHeadersController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Payment headers'
			if params[:search]
  			@payment_headers = PaymentHeader.onlymine(@session_user).search(params[:search]).order(sort_order(:user_id)).paginate :page => params[:page]
			elsif params[:account_name]
  			@payment_headers = PaymentHeader.onlymine(@session_user).search_account(params[:account_name]).order(sort_order(:user_id)).paginate :page => params[:page]
			else
  			@payment_headers = PaymentHeader.onlymine(@session_user).order(sort_order(:user_id)).paginate :page => params[:page]
			end
    end
  
    def show
      @casein_page_title = 'View payment header'
      @payment_header = PaymentHeader.find params[:id]
    end

    def new_by_last
      @casein_page_title = 'New payment header'
      last_payment_header = PaymentHeader.find params[:id]
			@payment_header = last_payment_header.dup
			@payment_header.slip_no = SlipNo.get_num
			if @payment_header.save
				last_payment_header.payment_parts.each do |part|
					new_part = part.dup
					@payment_header.payment_parts << new_part
				end
			end
      render :action => :show
    end

		def pdf
      payment_header = PaymentHeader.find params[:id]
			pdf = PaymentReport.new(payment_header)
			send_data pdf.render,
				filename:	"payment.pdf",
				type:			"application/pdf",
				disposition:	"inline"
		end

		def add_part
      @payment_header = PaymentHeader.find(params[:id]) 
      @payment_header.payment_parts << PaymentPart.new
      render :action => :show
		end
  
    def new
      @casein_page_title = 'Add a new payment header'
			@account = Account.find(params[:account_id]);
    	@payment_header = PaymentHeader.new(
				:user_id => current_user.id,
				:account_id => @account.id,
				:slip_no => SlipNo.get_num
				)
    end

    def create
      @payment_header = PaymentHeader.new payment_header_params
			@payment_header.payment_parts.push PaymentPart.new
    
      if @payment_header.save
        flash[:notice] = 'Payment header created'
      	redirect_to casein_payment_header_path(@payment_header)
      else
        flash.now[:warning] = 'There were problems when trying to create a new payment header'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update payment header'
      
      @payment_header = PaymentHeader.find params[:id]
    
      if @payment_header.update_attributes payment_header_params
        flash[:notice] = 'Payment header has been updated'
        #redirect_to casein_payment_headers_path
        render :action => :show
      else
        flash.now[:warning] = 'There were problems when trying to update this payment header'
        render :action => :show
      end
    end
 
    def destroy
      @payment_header = PaymentHeader.find params[:id]

      @payment_header.destroy
      flash[:notice] = 'Payment header has been deleted'
      redirect_to casein_payment_headers_path
    end
  
    private
      
      def payment_header_params
        params.require(:payment_header).permit(:user_id, :account_id, :payable_on, :project_id, :org_name, :slip_no, :comment, :budget_code, :fee_who_paid)
      end

  end
end
