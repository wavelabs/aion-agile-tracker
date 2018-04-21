task calculate_iteration_number: :environment do
  Project.find_each do |project|
    project.iterations.order(:start_date).each_with_index do |iteration, index|
      iteration.update(number: index + 1)
    end
  end
end
