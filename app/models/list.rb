class List < ApplicationRecord
  has_many :tasks

  def complete_all_tasks!
    tasks.each { |task| task.update(complete: true) }
    # tasks.update_all(complete: true) (active record)
  end

  def snooze_all_tasks!
    tasks.each { |task| task.snooze_hour! }
  end

  def total_duration
    # total = 0
    # tasks.each do |task|
    #   total += task.duration
    # end
    # return total

    tasks.reduce(0) { |sum, task| sum + task.duration }
    tasks.sum { |task| task.duration }
    # tasks.sum(:duration) (active record)
  end

  def incomplete_tasks
    # array_of_tasks = []
    # tasks.each do |task|
    #   if !task.complete
    #     array_of_tasks << task
    #   end
    # end
    # return array_of_tasks

    tasks.reject do |task|
      task.complete
    end
    tasks.reject { |task| task.complete }
    # tasks.where(complete: false) (active record)
  end

  def favorite_tasks
    # array_of_tasks = []
    # tasks.each do |task|
    #   if task.favorite
    #     array_of_tasks << task
    #   end
    # end
    # return array_of_tasks

    tasks.select { |task| task.favorite}
    # tasks.where(favorite: true) (active record)
  end
end
