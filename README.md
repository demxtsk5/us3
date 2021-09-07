#### Ansible Playbook

## Aufbau von zwei Instanzen via Ansible Playbook in der AmazonCloud

Hashtag: iaac - infrastructure as a code  

Variablen müssen nicht angepasst werden.  
Das Playbook ist nicht universell einsatzbar.  
Was macht das Playbook:  
- Es wird ein Passwort für den ec2-user gesetzt 
- Es wird ssh mit Passwortautentifizierung erlaubt  
- es wird ein Inventory geschrieben (lokal Dateiname: inventory)

<details>
<summary>
Beispielaufruf:
</summary>
  
```
L00026:us3 mg0050$ ansible-playbook create_ansible_instances.yml

PLAY [baue ec2 instanzen für einen ansible workshop] *********************************************************************************************************

TASK [loesche altes Inventory] *******************************************************************************************************************************
changed: [localhost]

TASK [führe terraform aus] ***********************************************************************************************************************************
changed: [localhost]

TASK [debug] *************************************************************************************************************************************************
ok: [localhost] => {
    "terraform_output": {
        "changed": true,
        "command": "/Applications/terraform apply -no-color -input=false -auto-approve=true -lock=true /var/folders/3z/8700fqbn4dl1th20gjyfjzs80000gn/T/tmpi0y5mfzz.tfplan",
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
                    "18.196.46.244",
                    "3.69.231.211"
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
                    "10.0.0.70",
                    "10.0.0.85"
                ]
            }
        },
        "state": "present",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "aws_vpc.ansible_vpc: Creating...\naws_vpc.ansible_vpc: Creation complete after 1s [id=vpc-09d6f6df6ea9fdf8e]\naws_internet_gateway.ansible_igw: Creating...\naws_subnet.ansible_pub1: Creating...\naws_security_group.ansible_seg: Creating...\naws_subnet.ansible_pub1: Creation complete after 1s [id=subnet-05811b9badce5bd23]\naws_internet_gateway.ansible_igw: Creation complete after 1s [id=igw-0d159988edf67cbba]\naws_route_table.ansible_rtb: Creating...\naws_security_group.ansible_seg: Creation complete after 2s [id=sg-0b89f5f28dc6379d9]\naws_instance.ansible_instanz[0]: Creating...\naws_instance.ansible_instanz[1]: Creating...\naws_route_table.ansible_rtb: Creation complete after 1s [id=rtb-0397f78daaa830b09]\naws_route_table_association.ansible_subnet-connect1: Creating...\naws_route_table_association.ansible_subnet-connect1: Creation complete after 0s [id=rtbassoc-00aa00ba809ea64ff]\naws_instance.ansible_instanz[0]: Still creating... [10s elapsed]\naws_instance.ansible_instanz[1]: Still creating... [10s elapsed]\naws_instance.ansible_instanz[0]: Still creating... [20s elapsed]\naws_instance.ansible_instanz[1]: Still creating... [20s elapsed]\naws_instance.ansible_instanz[0]: Still creating... [30s elapsed]\naws_instance.ansible_instanz[1]: Still creating... [30s elapsed]\naws_instance.ansible_instanz[0]: Creation complete after 32s [id=i-06fda2b9daa28fc7a]\naws_instance.ansible_instanz[1]: Still creating... [40s elapsed]\naws_instance.ansible_instanz[1]: Creation complete after 42s [id=i-0896354ba644be277]\n\nApply complete! Resources: 8 added, 0 changed, 0 destroyed.\n\nOutputs:\n\nIP_Adressen = [\n  \"18.196.46.244\",\n  \"3.69.231.211\",\n]\nIP_internal = [\n  \"10.0.0.70\",\n  \"10.0.0.85\",\n]\n",
        "stdout_lines": [
            "aws_vpc.ansible_vpc: Creating...",
            "aws_vpc.ansible_vpc: Creation complete after 1s [id=vpc-09d6f6df6ea9fdf8e]",
            "aws_internet_gateway.ansible_igw: Creating...",
            "aws_subnet.ansible_pub1: Creating...",
            "aws_security_group.ansible_seg: Creating...",
            "aws_subnet.ansible_pub1: Creation complete after 1s [id=subnet-05811b9badce5bd23]",
            "aws_internet_gateway.ansible_igw: Creation complete after 1s [id=igw-0d159988edf67cbba]",
            "aws_route_table.ansible_rtb: Creating...",
            "aws_security_group.ansible_seg: Creation complete after 2s [id=sg-0b89f5f28dc6379d9]",
            "aws_instance.ansible_instanz[0]: Creating...",
            "aws_instance.ansible_instanz[1]: Creating...",
            "aws_route_table.ansible_rtb: Creation complete after 1s [id=rtb-0397f78daaa830b09]",
            "aws_route_table_association.ansible_subnet-connect1: Creating...",
            "aws_route_table_association.ansible_subnet-connect1: Creation complete after 0s [id=rtbassoc-00aa00ba809ea64ff]",
            "aws_instance.ansible_instanz[0]: Still creating... [10s elapsed]",
            "aws_instance.ansible_instanz[1]: Still creating... [10s elapsed]",
            "aws_instance.ansible_instanz[0]: Still creating... [20s elapsed]",
            "aws_instance.ansible_instanz[1]: Still creating... [20s elapsed]",
            "aws_instance.ansible_instanz[0]: Still creating... [30s elapsed]",
            "aws_instance.ansible_instanz[1]: Still creating... [30s elapsed]",
            "aws_instance.ansible_instanz[0]: Creation complete after 32s [id=i-06fda2b9daa28fc7a]",
            "aws_instance.ansible_instanz[1]: Still creating... [40s elapsed]",
            "aws_instance.ansible_instanz[1]: Creation complete after 42s [id=i-0896354ba644be277]",
            "",
            "Apply complete! Resources: 8 added, 0 changed, 0 destroyed.",
            "",
            "Outputs:",
            "",
            "IP_Adressen = [",
            "  \"18.196.46.244\",",
            "  \"3.69.231.211\",",
            "]",
            "IP_internal = [",
            "  \"10.0.0.70\",",
            "  \"10.0.0.85\",",
            "]"
        ],
        "workspace": "default"
    }
}

TASK [Erzeuge dynamisches Inventory] *************************************************************************************************************************
ok: [localhost] => (item=18.196.46.244)
ok: [localhost] => (item=3.69.231.211)

TASK [Erzeuge statisches Inventory] **************************************************************************************************************************
changed: [localhost] => (item=18.196.46.244)
changed: [localhost] => (item=3.69.231.211)

PLAY [setze das Passwort für ec2-user und erlaube login] *****************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************
[WARNING]: Platform linux on host 18.196.46.244 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python
interpreter could change the meaning of that path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more
information.
ok: [18.196.46.244]
[WARNING]: Platform linux on host 3.69.231.211 is using the discovered Python interpreter at /usr/bin/python, but future installation of another Python
interpreter could change the meaning of that path. See https://docs.ansible.com/ansible/2.10/reference_appendices/interpreter_discovery.html for more
information.
ok: [3.69.231.211]

TASK [wait for connection] ***********************************************************************************************************************************
ok: [3.69.231.211]
ok: [18.196.46.244]

TASK [setze Passwort] ****************************************************************************************************************************************
changed: [3.69.231.211]
changed: [18.196.46.244]

TASK [ändre sshd_config] *************************************************************************************************************************************
changed: [3.69.231.211]
changed: [18.196.46.244]

RUNNING HANDLER [ssh_restart] ********************************************************************************************************************************
changed: [3.69.231.211]
changed: [18.196.46.244]

PLAY RECAP ***************************************************************************************************************************************************
18.196.46.244              : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
3.69.231.211               : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost 
```
</details>