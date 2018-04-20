module Admin
  class AccountsController < BaseController
    before_action :set_account, only: [:show, :edit, :update, :destroy]

    # GET /accounts
    # GET /accounts.json
    def index
      @accounts_owned_by_me = Account.owned_by(current_user)
      @accounts             = Account.belongs(current_user)
    end

    # GET /accounts/new
    def new
      @account = current_user.accounts.build
    end

    # GET /accounts/1/edit
    def edit
    end

    # POST /accounts
    def create
      @account = ::NewAccountBuilder.new
                                    .assign_attributes(account_params)
                                    .set_owner(current_user)
                                    .build

      respond_to do |format|
        if @account.save
          format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
          format.json { render :show, status: :created, location: @account }
        else
          format.html { render :new }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /accounts/1
    # PATCH/PUT /accounts/1.json
    def update
      respond_to do |format|
        if @account.update(account_params)
          format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
          format.json { render :show, status: :ok, location: @account }
        else
          format.html { render :edit }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /accounts/1
    # DELETE /accounts/1.json
    def destroy
      @account.destroy
      respond_to do |format|
        format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_account
        @account = Account.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def account_params
        params.require(:account).permit(:name)
      end
  end
end
