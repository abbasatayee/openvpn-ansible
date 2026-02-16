# OpenVPN Ansible & Terraform Infrastructure

This project combines Terraform and Ansible to automatically provision and configure OpenVPN infrastructure on cloud servers.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Configuration](#configuration)
- [Running the Infrastructure](#running-the-infrastructure)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Tools

- **Terraform** (v1.0+) - Infrastructure as Code
- **Ansible** (v2.10+) - Configuration Management
- **Python** (v3.8+) - Required by Ansible
- **SSH** - For remote server access
- **Git** - For version control

### Install Dependencies

#### macOS (using Homebrew)
```bash
brew install terraform ansible python3
```

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install -y terraform ansible python3 python3-pip
pip3 install ansible
```

#### Check Installations
```bash
terraform version
ansible --version
python3 --version
```

### Cloud Provider Credentials

Ensure you have credentials configured for your cloud provider:

- **AWS**: Configure `~/.aws/credentials` or set environment variables
- **DigitalOcean**: Set `DIGITALOCEAN_TOKEN` environment variable
- **GCP**: Set `GOOGLE_APPLICATION_CREDENTIALS` environment variable
- **Other Providers**: Follow Terraform provider-specific documentation

## Project Structure

```
.
├── ansible.cfg                 # Ansible configuration
├── inventory/
│   └── hosts.yml              # Inventory of managed hosts
├── playbooks/
│   ├── site.yml               # Main playbook
│   └── artifacts/
│       └── client1.ovpn       # Generated client profiles
├── roles/
│   └── openvpn/
│       ├── defaults/
│       │   └── main.yml       # Default variables
│       ├── files/             # Static files
│       ├── handlers/
│       │   └── main.yml       # Handlers for service management
│       ├── tasks/
│       │   ├── main.yml       # Main tasks
│       │   ├── client_pki.yml # Client certificate generation
│       │   └── client_profile.yml # Client profile generation
│       └── templates/
│           ├── client.ovpn.j2 # Client config template
│           └── server.conf.j2 # Server config template
└── infra/
    └── terraform/
        ├── main.tf            # Main Terraform config
        ├── variables.tf       # Input variables
        ├── outputs.tf         # Output values
        └── modules/
            └── servers/       # Server module
```

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd openvpn-ansible
```

### 2. Install Ansible Collections

```bash
ansible-galaxy install -r requirements.yml 2>/dev/null || echo "No requirements.yml found"
```

### 3. Configure Cloud Credentials

Set up your cloud provider credentials (example for AWS):

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 4. Create Terraform Variables File

Create `infra/terraform/terraform.tfvars`:

```hcl
region             = "us-east-1"
instance_type      = "t3.micro"
server_count       = 1
environment        = "production"

# Your other variables here
```

### 5. Set Up Ansible Inventory

Edit `inventory/hosts.yml` with your server details:

```yaml
all:
  hosts:
    vpn_server_1:
      ansible_host: 10.0.0.1
      ansible_user: ec2-user
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
  vars:
    ansible_python_interpreter: /usr/bin/python3

openvpn_servers:
  children:
    production:
      hosts:
        vpn_server_1:
```

### 6. Create Ansible Vault for Secrets (Optional)

```bash
ansible-vault create group_vars/all/vault.yml
```

Store sensitive data like passwords and API keys in the vault file.

## Configuration

### Ansible Configuration

Edit `ansible.cfg` to customize Ansible behavior:

```ini
[defaults]
inventory = inventory/hosts.yml
remote_user = ec2-user
private_key_file = ~/.ssh/id_rsa
host_key_checking = False
```

### OpenVPN Role Variables

Edit `roles/openvpn/defaults/main.yml`:

```yaml
openvpn_port: 1194
openvpn_protocol: udp
openvpn_cipher: AES-256-GCM
openvpn_auth: SHA256
openvpn_network: 10.8.0.0
openvpn_netmask: 255.255.255.0
```

## Running the Infrastructure

### Option 1: Using Terraform + Ansible (Full Automation)

#### 1. Initialize Terraform

```bash
cd infra/terraform
terraform init
```

#### 2. Preview Infrastructure Changes

```bash
terraform plan
```

#### 3. Apply Terraform Configuration

```bash
terraform apply
```

#### 4. Run Ansible Playbook

```bash
cd ../..
ansible-playbook playbooks/site.yml -i inventory/hosts.yml
```

### Option 2: Using Existing Servers (Ansible Only)

If you already have servers provisioned, just run Ansible:

```bash
ansible-playbook playbooks/site.yml -i inventory/hosts.yml
```

### Option 3: Run with Vault

If using Ansible Vault for secrets:

```bash
ansible-playbook playbooks/site.yml -i inventory/hosts.yml --ask-vault-pass
```

Or provide the vault password file:

```bash
ansible-playbook playbooks/site.yml -i inventory/hosts.yml --vault-password-file ~/.vault_pass
```

## Common Tasks

### Generate Client Certificates and Profiles

```bash
ansible-playbook playbooks/site.yml -i inventory/hosts.yml --tags "client_pki"
```

### Download Generated Client Profiles

Client profiles are generated in `playbooks/artifacts/`:

```bash
ls playbooks/artifacts/
```

### Test Connectivity

```bash
ansible all -i inventory/hosts.yml -m ping
```

### View Server Information

```bash
cd infra/terraform
terraform output
```

### Destroy Infrastructure (Terraform)

```bash
cd infra/terraform
terraform destroy
```

## Troubleshooting

### SSH Connection Issues

**Problem**: `Permission denied (publickey)`

**Solution**:
```bash
# Verify key permissions
chmod 600 ~/.ssh/id_rsa

# Test SSH connection
ssh -i ~/.ssh/id_rsa user@host -v
```

### Terraform State Lock

**Problem**: `Error acquiring the lock`

**Solution**:
```bash
cd infra/terraform
terraform force-unlock <LOCK_ID>
```

### Ansible Inventory Issues

**Problem**: `Unable to parse inventory`

**Solution**:
```bash
ansible-inventory -i inventory/hosts.yml --list
```

### Python Not Found on Remote

**Problem**: `module_utils/basic.py not found`

**Solution**: Set Python interpreter in inventory:
```yaml
ansible_python_interpreter: /usr/bin/python3
```

## Security Notes

- **Never commit** `.tfvars` files with real credentials
- **Use Ansible Vault** for sensitive data
- Keep `SSH keys` out of version control (see `.gitignore`)
- Regularly **rotate certificates and keys**
- Use **strong VPN credentials**
- Monitor OpenVPN logs for unauthorized access

## Documentation

For detailed information, see:

- [Terraform Documentation](https://www.terraform.io/docs)
- [Ansible Documentation](https://docs.ansible.com/)
- [OpenVPN Documentation](https://openvpn.net/community/documentation/)

## Support

For issues or questions:
1. Check the `Troubleshooting` section above
2. Review Terraform/Ansible output logs
3. Check server logs: `cat /var/log/openvpn/openvpn.log`

## License

[Add your license here]

## Contributors

[List contributors here]
