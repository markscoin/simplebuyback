class EmailProcessor < ActiveRecord::Base
  def user_params
  params.require(:emailprocessor).permit(:body,:email)
  end
end
