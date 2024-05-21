class Record::WeighInsController < ApplicationController
  def new
    @weigh_in = weigh_in.new
  end

  def create
    @weigh_in = WeighIn.new(weigh_in_params)
    if @weigh_in.valid? # 手動でバリデーションの検証をする
      session[:weigh_in] = @weigh_in.weight # セッションに一時保存
      redirect_to new_record_squat_path # 次のステップへ遷移
    else
      render :new
    end
  end

  private

  def weigh_in_params
    params.require(:record_weigh_in).permit(:weight)
  end
end
