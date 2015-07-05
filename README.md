veritas
=======

A web application for social groups to share contact info, calendar events, track attendance and more.

## Setup
The following files need to be created.  There are [file_name].example files in this repository that can serve as a template.

- `config/database.yml` (database configuration)
- `client_secrets.json` (Google API secrets for Google Calendar integration)
- `ansible/group_vars/production` (production settings)
- `ansible/production`  (production server inventory file)

## Configuration Management Scripts 

From `/ansible` directory:
 - **Provision**: ansible-playbook -i production provision.yml
 - **Deploy**: ansible-playbook -i production deploy.yml

## Screenshot

![alt tag](https://raw.githubusercontent.com/bradyholt/veritas/master/app/assets/images/veritas-screen-shot.png)
