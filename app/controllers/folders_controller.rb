class FoldersController < ApplicationController


def create
	if  params[:name].nil?
			flash[:notice] = "Folders name can't be blank"
		else
			if folder = Folder.create(folder_params)
			 flash[:notice] = "your folder was successfuly added"

			else	
				flash[:notice] = "Something went wrong plese try again"
			end
		end
		redirect_to  home_path
end


private

def folder_params
   params.require(:folder).permit(:name).merge(user_id: current_user.id)

end
end
