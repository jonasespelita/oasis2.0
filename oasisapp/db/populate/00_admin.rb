admin1 = Admin.new
admin1.username = 'ausername'
admin1.last_name = 'lasty'
admin1.first_name = 'firsty'
admin1.position = 'positiony'
admin1.active = true
admin1.email = 'emaily@email.mail'
admin1.create_password('passwordy')
admin1.save
