class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :project

  attr_accessor :log_writer

  after_create ->  { invite_log }
  after_update ->  { (accept ? join_log : quit_to_join_log) if log_writer }
  after_destroy -> { quit_to_invite_log }

  def invite_log
    content = "#{project.user.name}さんが#{user.name}さんを招待しています。"
    Log.create!(content: content, image: project.user.image, project_id: project.id)
  end

  def join_log
    content = "#{log_writer.name}さんがこのプロジェクトに参加しました。"
    Log.create!(content: content, image: log_writer.image, project_id: project.id)
  end

  def quit_to_invite_log
    content = "#{project.user.name}さんが#{user.name}への招待をとりやめました。"
    Log.create!(content: content, image: project.user.image, project_id: project.id)
  end

  def quit_to_join_log
    content = "#{log_writer.name}さんがこのプロジェクトからぬけました。"
    Log.create!(content: content, image: log_writer.image, project_id: project.id)
  end

  scope :notification_pages, ->(p) do
    includes(:project).order(created_at: :desc).page(p[:page]).per(5)
  end

  def set_log_writer(user)
    self.log_writer = user
  end
end
