veritas
=======

A web application for social groups to share contact info, calendar events, track attendance and more.

## Setup
The following files need to be created.  There are [file_name].example files in this repository that can serve as a template.

- `config/database.yml` (database configuration)
- `client_secrets.json` (Google API secrets for Google Calendar integration)
- `ansible/production`  (production server inventory file)
- `ansible/group_vars/production` (production settings)

Per the provisioning script, MySQL db backups will be stored at the S3 location definded by the variable: `s3_db_backup_location`.  It is recommended to setup a lifecycle policy on the S3 bucket so that backups will be automatically deleted after a certain number of days.

## Configuration Management Scripts 

From `/ansible` directory:
 - **Provision**: ansible-playbook -i production provision.yml
 - **Deploy**: ansible-playbook -i production deploy.yml

## Screenshot

![alt tag](https://raw.githubusercontent.com/bradyholt/veritas/master/app/assets/images/veritas-screen-shot.png)
