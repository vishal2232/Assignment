1. Make sure we are using ansible version v2.6.4 (to check the ansible version run command -> ansible --version)
2. Make sure we have a windows server and powershell version is above than v4.0, otherwise we need to update the powershell version.
3. Make sure we have pywinrm module installed on client where we are running the ansible playbook
4. Need to have inventory before running the ansible playbook.
5. If above steps are done, then we just need to run the playbook using the below command

   "ansible-playbook -i inventory Win-Service-Allow.yaml"
