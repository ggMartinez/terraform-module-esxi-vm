# VMware ESXi - Terraform

Example to create ESXi VM with Terraform.
No vCenter needed! Just a standalone ESXi host. For the poor people.

## Requirements
You can guess them...

 - Terraform installed on your host (at least version 0.13)
 - A host with VMware ESXi. VMs don't run in trees.

## Run
Clone this. Copy `variables.tf.sample` to `variables.tf`, fill the values, and enjoy.
If you wish, you can edit "useradata.tpl" to run some startup commands. If you don't, then don't.

After that, the usual:

    terraform init
    terraform apply

And boila! You have your VM.

This is JUST an example. Should be used with more love and fancyness, for example, build a module. But not in the mood today for that.


## References
Based on this repo: https://github.com/josenk/terraform-provider-esxi.
It may change, don't think I will watch it every day. So f*ck it.

