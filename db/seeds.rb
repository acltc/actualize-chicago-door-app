admin_role = Role.create!(name: "admin", description: "Full time employees with no time restrictions on building access")
student_role = Role.create!(name: "student", description: "Students with school hour time restrictions on building access")

TimeSlot.create!(weekday: "Sunday", start_hour: 8, start_min: 0, end_hour: 18, end_min: 0, role_id: student_role.id, daily: false)
TimeSlot.create!(weekday: "Monday", start_hour: 8, start_min: 0, end_hour: 18, end_min: 0, role_id: student_role.id, daily: false)
TimeSlot.create!(weekday: "Tuesday", start_hour: 8, start_min: 0, end_hour: 18, end_min: 0, role_id: student_role.id, daily: false)
TimeSlot.create!(weekday: "Wednesday", start_hour: 8, start_min: 0, end_hour: 18, end_min: 0, role_id: student_role.id, daily: false)
TimeSlot.create!(weekday: "Thursday", start_hour: 8, start_min: 0, end_hour: 18, end_min: 0, role_id: student_role.id, daily: false)
TimeSlot.create!(weekday: "Friday", start_hour: 8, start_min: 0, end_hour: 18, end_min: 0, role_id: student_role.id, daily: false)
