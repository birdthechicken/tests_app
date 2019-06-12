require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should change complete attribute to false if it begin as true' do
        task = Task.create(complete: true)
        task.toggle_complete!
        expect(task.complete).to eq(false)
    end 

    it 'should change complete attribute to true if it begin as false' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should change favorite attribute to true if it begin as false' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end 

    it 'should change favorite attribute to false if it begin as true' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?'do
    it 'should return false if current time is earlier than deadline' do
      task = Task.create(deadline: 1.hour.from_now)
      expect(task.overdue?).to eq(false)
    end
     it 'should return true if current time is later than deadline' do
      task = Task.create(deadline: 1.hour.ago)
      expect(task.overdue?).to eq(true)
    end
  end

  describe '#increment_priority!' do
    it 'should increase the priority by 1' do
      task = Task.create(priority: 2)
      task.increment_priority!
      expect(task.priority).to eq(3)
    end

    it 'should not increment the priority beyond 10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    it 'should decrease priority by 1' do
      task = Task.create(priority: 2)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end

    it 'should not decrement the priority beyond 1' do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should increase the deadline by 1 hour' do
      time = Time.now
      task = Task.create(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end
end


