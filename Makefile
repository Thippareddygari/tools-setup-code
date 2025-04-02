infra:
	 git pull
	 terraform init
	 terraform apply -auto-approve

ansible:
	 git pull
	 #ansible-playbook -i $(tool_name).internal.kommanuthala.store, setup-tool.yml -e ansible_username=ec2-user -e ansible_password=DevOps321 -e tool_name=$(tool_name)
	 ansible-playbook -i $(tool_name).kommanuthala.store, setup-tool.yml -e ansible_username=ec2-user -e ansible_password=DevOps321 -e tool_name=$(tool_name)