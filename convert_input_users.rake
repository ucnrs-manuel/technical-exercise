namespace :db do
  desc "convert input users format to output users"
  task convert_input_users: :environment do
    InputUser.all.each do |user|
     # employee_id = user.employee_id
     # name = user.name     

      (1..5).each do |i|
        appointment = user.send("appointment_period#{i}").split("|")

        if appointment.present? && appointment[1].to_date > Date.current
          OutputUser.create({ 
            employee_id: user.employee_id,
            name: user.name,
            department_id: user.send("department_id#{i}"),
            title_code: user.send("title_code#{i}"),
            title_name: "",
            step: user.send("step#{i}"),
            appt_begin_date: appointment[0].to_date.strftime("%D"),
            appt_end_date: appointment[1].to_date.strftime("%D"),
          })

        end
      end
    end
  end
end