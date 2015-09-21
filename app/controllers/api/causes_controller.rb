class Api::CausesController < Api::ApiController
	CAUSE_RESPONSE_KEY = "cause"

	def create
		response = CreateCauseService.new(create_cause_params).perform
		if response.success?
			cause = response.result
			render_default_cause_response(cause)
		else
			render_error(:unauthorized,response.errors)
		end
	end

	def index
		@all_causes = Cause.all
		render_list_of_causes(@all_causes)
	end

	def get
		cause = Cause.find_by(id:params[:id])
		if cause.present?
			render_default_cause_response(cause)
		else
			render_error(:bad_request,"Cannot find cause with id "+ params[:id])
		end
	end

	def join
		cause = Cause.find_by(id:params[:id])
		response = JoinCauseService.new(@current_user,cause).perform
		if response.success?
			render_default_cause_response(cause)
		else
			render_error(:bad_request,response.errors)
		end
	end

	def get_user_causes
		@user_causes = @current_user.causes
		render_list_of_causes(@user_causes)
	end

	def get_causes_from_categories
		response = CategoryCausesService.new(causes_from_category_params).perform
		if response.success?
			causes = response.result
			render_default_cause_response(causes)
		else
			render_error(404,response.errors)
		end
	end

	private
	    '''PARAMS '''
	    def create_cause_params 
	     	params.require(CAUSE_RESPONSE_KEY).permit(:name,:description, :category)
	    end

		def causes_from_category_params
			params.require(:categories)
		end

	    '''RENDER'''
	    def render_default_cause_response(cause)
			render status: :ok , json: cause.as_json
			
		end

		def render_list_of_causes(causes)
	    	render status: :ok , json: causes.as_json
	    end

end
