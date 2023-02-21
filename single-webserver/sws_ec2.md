This terraform script creates aws ec2 instance with pre-configuration known as user_data.

The <<-EOF and EOF are Terraform's heredoc syntax and allows multiline strings without having to insert \n characters.

The user_data_replace_on_change parameter is set to true which will terminate the original instance and launch a totally new one, default behavior is to update the original instance in place, but since User Data runs only on the very first boot, and your original instance already went through that boot process, you need to force the creation of new instance to ensure your new User Data script actually gets executed.

We need to add security_group_id to instance configuration by adding "aws_security_group.instance.id" which is attribute reference and can be represented as "PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>."  We can use this security group ID in the vpc_security_group_ids argument of the aws_instance.

When you add a reference from one resource to another, you create an
implicit dependency. Terraform parses these dependencies, builds a
dependency graph from them, and uses that to automatically determine in
which order it should create resources. For example, if you were deploying
this code from scratch, Terraform would know that it needs to create the
security group before the EC2 Instance, because the EC2 Instance
references the ID of the security group. You can even get Terraform to show
you the dependency graph by running the graph command:
$ terraform graph
