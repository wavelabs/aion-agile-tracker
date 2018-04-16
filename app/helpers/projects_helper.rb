module ProjectsHelper
  def progress_color(progress)
    case progress
    when 0..40 then 'bg-red'
    when 41..80 then 'bg-yellow'
    when 81..1000 then 'bg-green'
    end
  end
end
