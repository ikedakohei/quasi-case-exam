class ColumnDecorator < Draper::Decorator
  delegate_all

  def left_end?
    object.order == 0
  end

  def right_end?
    object.order == object.project.columns.count - 1
  end
end
