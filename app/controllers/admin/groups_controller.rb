class Admin::GroupsController < Admin::ApplicationController
  helper "admin/permissions"
  before_filter :find_group, :only => [:show, :edit, :update, :destroy]
  before_filter :store_location, :only => :index
  def index
    @groups = Group.all
  end
  
  def show
    redirect_to admin_group_users_path(params[:id])
  end
  
  def new
    @group = Group.new
    @permission = @group.permissions.build
  end
  
  def create
    @group = Group.new(params[:group].merge!(:owner => current_user))
    if @group.save
      flash[:notice] = t(:group_created)
      redirect_to admin_groups_path
    else
      flash[:notice] = t(:group_not_created)
      render :action => "new"
    end
  end
  
  def edit
    @permission = @group.permissions.global
  end
  
  def update
    @permission = @group.permissions.global
    if @group.update_attributes(params[:group]) && @permission.update_attributes(params[:permission])
      flash[:notice] = t(:group_updated)
      redirect_back_or_default admin_groups_path
    else
      flash[:notice] = t(:group_not_updaed)
      render :action => "edit"
    end
  end
  
  def destroy
    @group.destroy
    flash[:notice] = t(:group_deleted)
    redirect_to admin_groups_path
  end
  
  private
  
    def find_group
      @group = Group.find(params[:id])
    rescue ActiveRecord::NotFound
      not_found
    end
    
    def not_found
      flash[:notice] = t(:not_found, :thing => "group")
      redirect_to admin_groups_path
    end
end
