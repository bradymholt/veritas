# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.delete_all
Setting.create(
	group_name: 'Group Name', 
	group_description: 'Group Description', 
	user_password: 'group_password', 
	admin_password: 'admin_password',
	aws_bucket_name: 'bucket',
	aws_access_key: 'JKFLKJDF90',
	aws_secret_acess_key: '9898DJKFJDKDDF')