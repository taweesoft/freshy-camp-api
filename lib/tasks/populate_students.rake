
task :populate_students => :environment do
  students = SmarterCSV.process('tmp/students.csv')
  students.each do |s|
    result = Student.create(s)
    puts "Added #{result.std_id} #{result.name}"
  end
end
