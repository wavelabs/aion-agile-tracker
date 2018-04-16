module Admin
  class AccountsController < BaseController
    before_action :set_account, only: [:show, :edit, :update, :destroy]

    # GET /accounts
    # GET /accounts.json
    def index
      @accounts = current_user.accounts
    end

    # GET /accounts/1
    # GET /accounts/1.json
    def show
      @users = @company.users
    end

    # GET /accounts/new
    def new
      @company = Company.new
    end

    # GET /accounts/1/edit
    def edit
    end

    # POST /accounts
    # POST /accounts.json
    def create
      @company = ::NewCompanyBuilder.new
                                    .assign_attributes(company_params)
                                    .add_user(current_user)
                                    .build

      respond_to do |format|
        if @company.save
          format.html { redirect_to @company, notice: 'Company was successfully created.' }
          format.json { render :show, status: :created, location: @company }
        else
          format.html { render :new }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /accounts/1
    # PATCH/PUT /accounts/1.json
    def update
      respond_to do |format|
        if @company.update(company_params)
          format.html { redirect_to @company, notice: 'Company was successfully updated.' }
          format.json { render :show, status: :ok, location: @company }
        else
          format.html { render :edit }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /accounts/1
    # DELETE /accounts/1.json
    def destroy
      @company.destroy
      respond_to do |format|
        format.html { redirect_to accounts_url, notice: 'Company was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_account
        @company = Company.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def company_params
        params.require(:company).permit(:name)
      end
  end
end