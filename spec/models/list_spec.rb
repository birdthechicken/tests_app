require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all tasks from the list as complete' do
      list = List.create(name: "My Favorite Things To Do")
      task = Task.create(complete: false, list_id: list.id)
      task = Task.create(complete: false, list_id: list.id)

      list.complete_all_tasks!

      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end

  describe '#snooze_all_tasks!' do
    it 'should increase the deadline by 1 hour' do
      time = Time.now
      list = List.create(name: "My Favorite Things To Do")
      Task.create(deadline: time, list_id: list.id)
      Task.create(deadline: time, list_id: list.id)

      list.snooze_all_tasks!

      list.tasks.each do |task|
        expect(task.deadline).to eq(time + 1.hour)
      end
      # expect(list.tasks[0].deadline).to eq(time + 1.hour)
      # expect(list.tasks[1].deadline).to eq(time + 1.hour)
    end
  end

  describe '#total_duration' do
    it 'should return the sum of the duration of tasks' do
      list = List.create(name: "My Favorite Things To Do")
      Task.create(duration: 10, list_id: list.id)
      Task.create(duration: 30, list_id: list.id)

      expect(list.total_duration).to eq(40)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return a list of all incomplete tasks' do
      list = List.create(name: "My Favorite Things To Do")
      Task.create(complete: true, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)
      Task.create(complete: false, list_id: list.id)

      array_of_tasks = []

      list.tasks.each do |task|
        if task.complete == false
        array_of_tasks << task
        end
      end

      # array_of_tasks = [list.tasks[1], list.tasks[2], list.tasks[3]]
      expect(list.incomplete_tasks).to eq(array_of_tasks)
      expect(list.incomplete_tasks.length).to eq(3)

    end
  end

  describe '#favorite_tasks' do 
    it 'should return a list of favorite tasks' do
      list = List.create(name: "My Favorite Things To Do")
      task = Task.create(favorite: true, list_id: list.id)
      task = Task.create(favorite: true, list_id: list.id)
      task = Task.create(favorite: true, list_id: list.id)
      task = Task.create(favorite: false, list_id: list.id)
      task = Task.create(favorite: false, list_id: list.id)

      array_of_tasks = []

      list.tasks.each do |task|
        if task.favorite == true
        array_of_tasks << task
        end
      end
      # array_of_tasks = [ list.tasks[0], list.tasks[1], list.tasks[2], list.tasks[3], list.tasks[4]]
      expect(list.favorite_tasks).to eq(array_of_tasks)

      list.favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end
end
