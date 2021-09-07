## Ansible Playbook

### Aufbau von zwei Instanzen via Ansible Playbook in der AmazonCloud

#### Hashtag: iaac - infrastructure as a code  

Variablen müssen nicht angepasst werden.  
Das Playbook ist nicht universell einsatzbar.  
Was macht das Playbook:  
- Es wird ein Passwort für den ec2-user gesetzt  
- Das Passwort ist mit ansible vault verschlüsselt
- Es wird ssh mit Passwortautentifizierung erlaubt  
- es wird ein Inventory geschrieben (lokal Dateiname: inventory)  
- Abbau mit _terraform destroy -auto-approve_

<details>
<summary>
Beispielaufruf:
</summary>
  
```
L00026:us3 mg0050$ ansible-playbook create_ansible_instances.yml --ask-vault-pass
Vault password: 

PLAY [baue ec2 instanzen für einen ansible workshop] *********************************************************************************************************

TASK [loesche altes Inventory] *******************************************************************************************************************************
changed: [localhost]

TASK [führe terraform aus] ***********************************************************************************************************************************
changed: [localhost]

TASK [debug] *************************************************************************************************************************************************
ok: [localhost] => {
    "terraform_output": {
        "changed": true,
        "command": "/Applications/terraform apply -no-color -input=false -auto-approve=true -lock=true /var/folders/3z/8700fqbn4dl1th20gjyfjzs80000gn/T/tmpytqjvcpy.tfplan",
        "failed": false,
        "outputs": {
            "IP_Adressen": {
                "sensitive": false,
                "type": [
                    "tuple",
                    [
                        "string",
                        "string"
                    ]
                ],
                "value": [
                    "18.184.219.30",
                    "54.93.245.58"
                ]
            },
            "IP_internal": {
                "sensitive": false,
                "type": [
                    "tuple",
                    [
                        "string",
                        "string"
                    ]
                ],
                "value": [
                    "10.0.0.69",
                    "10.0.0.112"
                ]
            }
        },
        "state": "present",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "aws_vpc.ansible_vpc: Creating...\naws_vpc.ansible_vpc: Creation complete after 2s [id=vpc-08371222a971754a1]\naws_internet_gateway.ansible_igw: Creating...\naws_subnet.ansible_pub1: Creating...\naws_security_group.ansible_seg: Creating...\naws_subnet.ansible_pub1: Creation complete after 1s [id=subnet-0b3f3d5bbc2ce0bec]\naws_internet_gateway.ansible_igw: Creation complete after 1s [id=igw-08a5f573a36b98cf8]\naws_route_table.ansible_rtb: Creating...\naws_security_group.ansible_seg: Creation complete after 1s [id=sg-0375a58d658161a56]\naws_instance.ansible_instanz[1]: Creating...\naws_instance.ansible_instanz[0]: Creating...\naws_route_table.ansible_rtb: Creation complete after 1s [id=rtb-049a61b5a2b9fedda]\naws_route_table_association.ansible_subnet-connect1: Creating...\naws_route_table_association.ansible_subnet-connect1: Creation complete after 0s [id=rtbassoc-0f47f693778a40425]\naws_instance.ansible_instanz[1]: Still creating... [10s elapsed]\naws_instance.ansible_instanz[0]: Still creating... [10s elapsed]\naws_instance.ansible_instanz[0]: Still creating... [20s elapsed]\naws_instance.ansible_instanz[1]: Still creating... [20s elapsed]\naws_instance.ansible_instanz[1]: Still creating... [30s elapsed]\naws_instance.ansible_instanz[0]: Still creating... [30s elapsed]\naws_instance.ansible_instanz[0]: Still creating... [40s elapsed]\naws_instance.ansible_instanz[1]: Still creating... [40s elapsed]\naws_instance.ansible_instanz[1]: Creation complete after 43s [id=i-08f384b8c17bd7dc8]\naws_instance.ansible_instanz[0]: Still creating... [50s elapsed]\naws_instance.ansible_instanz[0]: Creation complete after 53s [id=i-0bfad36313f56510a]\n\nApply complete! Resources: 8 added, 0 changed, 0 destroyed.\n\nOutputs:\n\nIP_Adressen = [\n  \"18.184.219.30\",\n  \"54.93.245.58\",\n]\nIP_internal = [\n  \"10.0.0.69\",\n  \"10.0.0.112\",\n]\n",
        "stdout_lines": [
            "aws_vpc.ansible_vpc: Creating...",
            "aws_vpc.ansible_vpc: Creation complete after 2s [id=vpc-08371222a971754a1]",
            "aws_internet_gateway.ansible_igw: Creating...",
            "aws_subnet.ansible_pub1: Creating...",
            "aws_security_group.ansible_seg: Creating...",
            "aws_subnet.ansible_pub1: Creation complete after 1s [id=subnet-0b3f3d5bbc2ce0bec]",
            "aws_internet_gateway.ansible_igw: Creation complete after 1s [id=igw-08a5f573a36b98cf8]",
            "aws_route_table.ansible_rtb: Creating...",
            "aws_security_group.ansible_seg: Creation complete after 1s [id=sg-0375a58d658161a56]",
            "aws_instance.ansible_instanz[1]: Creating...",
            "aws_instance.ansible_instanz[0]: Creating...",
            "aws_route_table.ansible_rtb: Creation complete after 1s [id=rtb-049a61b5a2b9fedda]",
            "aws_route_table_association.ansible_subnet-connect1: Creating...",
            "aws_route_table_association.ansible_subnet-connect1: Creation complete after 0s [id=rtbassoc-0f47f693778a40425]",
            "aws_instance.ansible_instanz[1]: Still creating... [10s elapsed]",
            "aws_instance.ansible_instanz[0]: Still creating... [10s elapsed]",
            "aws_instance.ansible_instanz[0]: Still creating... [20s elapsed]",
            "aws_instance.ansible_instanz[1]: Still creating... [20s elapsed]",
            "aws_instance.ansible_instanz[1]: Still creating... [30s elapsed]",
            "aws_instance.ansible_instanz[0]: Still creating... [30s elapsed]",
            "aws_instance.ansible_instanz[0]: Still creating... [40s elapsed]",
            "aws_instance.ansible_instanz[1]: Still creating... [40s elapsed]",
            "aws_instance.ansible_instanz[1]: Creation complete after 43s [id=i-08f384b8c17bd7dc8]",
            "aws_instance.ansible_instanz[0]: Still creating... [50s elapsed]",
            "aws_instance.ansible_instanz[0]: Creation complete after 53s [id=i-0bfad36313f56510a]",
            "",
            "Apply complete! Resources: 8 added, 0 changed, 0 destroyed.",
            "",
            "Outputs:",
            "",
            "IP_Adressen = [",
            "  \"18.184.219.30\",",
            "  \"54.93.245.58\",",
            "]",
            "IP_internal = [",
            "  \"10.0.0.69\",",
            "  \"10.0.0.112\",",
            "]"
        ],
        "workspace": "default"
    }
}

TASK [Erzeuge dynamisches Inventory] *************************************************************************************************************************
ok: [localhost] => (item=18.184.219.30)
ok: [localhost] => (item=54.93.245.58)

TASK [Erzeuge statisches Inventory] **************************************************************************************************************************
changed: [localhost] => (item=18.184.219.30)
changed: [localhost] => (item=54.93.245.58)

PLAY [setze das Passwort für ec2-user und erlaube login] *****************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
[WARNING]: Platform linux on host 54.93.245.58 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python
interpreter could change the meaning of that path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more
information.
ok: [54.93.245.58]
[WARNING]: Platform linux on host 18.184.219.30 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python
interpreter could change the meaning of that path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more
information.
ok: [18.184.219.30]

TASK [wait for connection] ***********************************************************************************************************************************
ok: [18.184.219.30]
ok: [54.93.245.58]

TASK [setze Passwort] ****************************************************************************************************************************************
changed: [18.184.219.30]
changed: [54.93.245.58]

TASK [ändre sshd_config] *************************************************************************************************************************************
changed: [18.184.219.30]
changed: [54.93.245.58]

RUNNING HANDLER [ssh_restart] ********************************************************************************************************************************
changed: [18.184.219.30]
changed: [54.93.245.58]

PLAY RECAP ***************************************************************************************************************************************************
18.184.219.30              : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
54.93.245.58               : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

L00026:us3 mg0050$ ssh ec2-user@18.184.219.30
ec2-user@18.184.219.30's password: 
Last login: Tue Sep  7 10:02:09 2021 from p5b0b5a5d.dip0.t-ipconnect.de

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
4 package(s) needed for security, out of 16 available
Run "sudo yum update" to apply all updates.
[ec2-user@ip-10-0-0-69 ~]$ Abgemeldet
Connection to 18.184.219.30 closed.
```
</details>